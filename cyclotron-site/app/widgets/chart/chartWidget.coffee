###
# Copyright (c) 2013-2015 the original author or authors.
#
# Licensed under the MIT License (the "License");
# you may not use this file except in compliance with the License. 
# You may obtain a copy of the License at
#
#     http://www.opensource.org/licenses/mit-license.php
#
# Unless required by applicable law or agreed to in writing, 
# software distributed under the License is distributed on an 
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
# either express or implied. See the License for the specific 
# language governing permissions and limitations under the License. 
###

#
# Chart Widget
#
# Requires a dataService property to load data
# Support dataServices that return object-based data:
#
#    Object-based (keys are columns):
#        [ 
#            {color: "red", number: 1, state: "WA"}
#            {color: "green", number: 41, state: "CA"}
#        ]
#
# Headers are generated by looking at the complete list of data and
# extracting a list of unique columns.  Data Source-provided headers are ignored
# since some columns may have no data.
#

cyclotronApp.controller 'ChartWidget', ($scope, dashboardService, dataService) ->

    $scope.loading = false
    $scope.dataSourceError = false
    $scope.dataSourceErrorMessage = null

    $scope.widgetTitle = -> _.jsExec $scope.widget.title

    # Load data source
    dsDefinition = dashboardService.getDataSource($scope.dashboard, $scope.widget)
    $scope.dataSource = dataService.get(dsDefinition)

    # Load drilldown data source (optional)
    drilldownDataSourceDefinition = dashboardService.getDataSource($scope.dashboard, $scope.widget, 'drilldownDataSource')
    $scope.drilldownDataSource = dataService.get(drilldownDataSourceDefinition)

    getChart = ->
        defaults =
            credits:
                enabled: false
            exporting:
                enabled: false
            plotOptions: {}
            title:
                text:  null

        # Merge dashboard options with the defaults
        chart = _.merge(defaults, $scope.widget.highchart)
        chart = _.compile(chart, {}, ['series'], true)
        return chart

    getSeries = (series, seriesData = $scope.rawData) ->

        # Compile top-level properties
        series = _.compile series, [], [], false
        if series._x then series.x = series._x
        if series._y then series.y = series._y
        if series._z then series.z = series._z
        if series._point then series.point = series._point

        # Support formating
        xTransform = null
        if series.xFormat?
            xTransform = switch series.xFormat
                when "epoch" then (d) ->
                    moment.unix(d).valueOf()
                when "epochmillis" then _.identity
                    # Highcharts handles natively
                when "string" then (d) ->
                    moment(d).valueOf()

                else _.identity

        # If point is provided, use it's properties to create point objects
        if series.point?
            series.data = _.map seriesData, (row) ->
                point = _.cloneDeep(series.point)

                # Pull in series x/y/z unless they are defined on the point
                if !point.x? && series.x?
                    point.x = row[series.x]
                if !point.y? && series.y?
                    point.y = row[series.y]
                if !point.z? && series.z?
                    point.z = row[series.z]

                # Evaluate all properties for variables/inline JS
                point = _.compile(point, row, [], true, true)

                # Optional x-transform
                if point.x? && xTransform?
                    point.x = xTransform(point.x)

                # Optional Drilldown
                if point.drilldown?
                    point.drilldown = point.drilldown.toString()

                return point

            # Remove series-level properties since all data has been pulled into the data array
            series._x = series.x
            series._y = series.y
            series._z = series.z
            series._point = series.point
            delete series.x
            delete series.y
            delete series.z
            delete series.point

        # Handle different combinations of x/y/z
        else if series.x? && series.y? && series.z?
            series.data = _.map seriesData, (row) ->
                xValue = row[series.x] ? null
                yValue = row[series.y] ? null
                zValue = row[series.z] ? null

                # Optionally format the x axis
                if xTransform? then xValue = xTransform(xValue)

                return [xValue, yValue, zValue]

        else if series.x? && series.y?
            series.data = _.map seriesData, (row) ->
                xValue = row[series.x] ? null
                yValue = row[series.y] ? null

                # Optionally format the x axis
                if xTransform? then xValue = xTransform(xValue)

                return [xValue, yValue]

        # Y only
        else if !series.x? && series.y?
            series.data = _.map seriesData, (row) ->
                return row[series.y] ? null

        # X only
        else if !series.y? && series.x?
            series.data = _.map seriesData, (row) ->
                xValue = row[series.x] ? null

                # Optionally format the x axis
                if xTransform? then xValue = xTransform(xValue)

                return xValue

        else
            series.data = []
        

        if series._titleCase
            series.name = _.titleCase series.name

        return series

    $scope.createChart = ->

        # Get the chart options
        chart = getChart()

        # Load the series from the chart
        $scope.series = series = chart.series

        # Use series object if provided, otherwise generate from headers/data
        if _.isNullOrUndefined series
            # Map headers to series
            series = _.map $scope.headers, (header) ->
                { type: 'line', y: header }

        # jsExec the series name, in case it is a function.
        # If it is, it will be used to generate the series name
        _.each series, (s) ->
            s.name = _.jsExec(s.name)

        # Handle wildcard series with '*' or a regex //
        stars = _.filter(series, (s) ->
            return false unless s.y?
            return s.y == '*' || /^\/.*\/$/i.test(s.y)
        )

        if stars?
            remainingSeries = _.reject(series, (s) -> _.contains(stars, s))

            # Handle each star series in order, adding series to remanining series
            _.each stars, (star) ->

                # Get possible y series by excluding other series' x/y fields
                starSeriesY = _.reject $scope.headers, (header) ->
                    return true if star.yIgnore && _.contains(star.yIgnore, header)
                    return true if header == star.x || header == star.z
                    return true if _.some(remainingSeries, (rem) ->
                        return true if header == rem.x
                        return true if header == rem.y
                        return true if header == rem.z
                        return false
                    )

                # Filter series list by regex, if it is a regex
                if /^\/.*\/$/i.test(star.y)
                    r = new RegExp(star.y.substring(1, star.y.length-1), "i")
                    starSeriesY = _.filter starSeriesY, (y) ->
                        return r.test(y)

                remainingSeries = _.union(remainingSeries, _.map(starSeriesY, (y) ->
                    expanded = _.defaults({ y: y }, star)

                    # Expand name if present, otherwise it will just be y
                    if expanded.name?
                        if _.isFunction expanded.name
                            expanded.name = expanded.name(y)
                        else
                            expanded.name = expanded.name + ": " + _.titleCase(y)

                    return expanded
                ))

            # Replace series with expanded list
            series = remainingSeries

        # Ensure each series has a name (use y name if necessary)
        _.each series, (aSeries) ->
            if _.isNullOrUndefined aSeries.name
                aSeries.name = aSeries.y
                aSeries._titleCase = true
            else if _.isFunction aSeries.name
                # Evaluate name function with y value
                aSeries.name = aSeries.name(aSeries.y)

        # Expand each series with the actual data and apply to the chart
        chart.series = _.map series, (s) -> getSeries(s, $scope.rawData)

        # Optional drilldown
        if chart.drilldown?
            # Expand each drilldown series
            expandedSeries = _.map chart.drilldown.series, (drilldownSeries) ->
                # Group the drilldown data by the series key
                groups = _.groupBy $scope.drilldownData, (row) ->
                    _.compile drilldownSeries.key, row

                _.map groups, (group, key) ->
                    s = getSeries _.cloneDeep(drilldownSeries), group
                    s.id = key.toString()
                    return s

            # Flatten and replace
            chart.drilldown.series = _.flatten expandedSeries

        # Set the highcharts object so the directive picks it up.
        $scope.highchart = chart

    $scope.loadDrilldownData = ->
        $scope.drilldownDataSource.getData drilldownDataSourceDefinition, (data) ->
            $scope.drilldownData = data
            $scope.createChart()

    # Load data from the data source
    $scope.loadData = ->
        # Reset scope variables
        $scope.loading = true
        $scope.dataSourceError = false
        $scope.dataSourceErrorMessage = null

        $scope.dataSource.getData(dsDefinition, (data, headers, isUpdate, diff) ->

            $scope.dataSourceError = false
            $scope.dataSourceErrorMessage = null

            # Filter the data with the widget filters if needed
            if $scope.widget.filters?
                data = dataService.filter(data, $scope.widget.filters)

            # Sort the data if the widget has sortBy
            if $scope.widget.sortBy?
                data = dataService.sort(data, $scope.widget.sortBy)

            # Check for no Data
            if _.isEmpty(data) && $scope.widget.noData?
                $scope.nodata = _.jsExec($scope.widget.noData)
            else
                $scope.nodata = null
                $scope.rawData = data

                previousHeaders = $scope.headers

                # Generates data headers (e.g. possible series) by inspecting the filtered data set
                # The keys of each row are unioned to get a complete list of columns
                $scope.headers = _.reduce data, (headers, dataRow) ->
                    _.union headers, _.keys(dataRow)
                , []

                $scope.createChart()

            $scope.loading = false

        , (errorMessage, status) ->
            $scope.loading = false

            # Error callback
            $scope.dataSourceError = true
            $scope.dataSourceErrorMessage = errorMessage
            $scope.nodata = null
        , ->
            $scope.loading = true
        )

    $scope.reload = ->
        $scope.dataSource.execute(true)

    # Initialize
    if not _.isUndefined(drilldownDataSourceDefinition)
        $scope.loadDrilldownData()

    if not _.isUndefined(dsDefinition)
        $scope.loadData()
