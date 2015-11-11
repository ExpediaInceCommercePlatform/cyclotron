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

# Common Config File - all default or shared configs
cyclotronServices.factory 'commonConfigService', ->

    datasourceOptions = (dashboard) ->
        dataSources = {}
        _.each dashboard.dataSources, (dataSource) ->
            dataSources[dataSource.name]  = { value: dataSource.name }

        dataSources

    exports = {

        version: '1.22.0'

        authentication:
            loginMessage: 'Please login using your LDAP username and password.'

        # Dashboard settings
        dashboard:
            properties:
                name:
                    label: 'Name'
                    description: 'Dashboard Name. This is required and cannot be changed after the Dashboard is created.'
                    placeholder: 'Dashboard Name'
                    type: 'string'
                    required: true
                    order: 0

                description:
                    label: 'Description'
                    description: 'A short summary of the Dashboard\'s purpose or capabilities.'
                    placeholder: 'A short summary of the Dashboard\'s purpose or capabilities.'
                    type: 'string'
                    required: false
                    order: 1

                theme:
                    label: 'Theme'
                    description: 'The default Page Theme for the Dashboard. If this property is set, the value will be applied to any Pages that have not specified a Theme. If it is not set, the default value of "Dark" will be used.'
                    type: 'string'
                    default: 'dark'
                    required: false
                    options:
                        light:
                            value: 'light'
                            dashboardBackgroundColor: 'white'
                        lightborderless:
                            value: 'lightborderless'
                            dashboardBackgroundColor: 'white'
                        gto:
                            value: 'gto'
                            dashboardBackgroundColor: 'white'
                        dark:
                            value: 'dark'
                            dashboardBackgroundColor: 'black'
                        dark2:
                            value: 'dark2'
                            dashboardBackgroundColor: 'black'
                    order: 2

                style:
                    label: 'Style'
                    description: 'The default Page Style for the Dashboard. If this property is set, the value will be applied to any Pages that have not specified a Style. If it is not set, the default value of "Normal" will be used.'
                    type: 'string'
                    default: 'normal'
                    required: false
                    options: 
                        normal:
                            value: 'normal'
                        fullscreen:
                            value: 'fullscreen'
                    defaultHidden: true
                    order: 3

                autoRotate:
                    label: 'Auto-Rotate'
                    description: 'If set to true, Cyclotron will automatically rotate between pages of the Dashboard based on the duration property for each Page. Set this value false to require manual rotation.'
                    type: 'boolean'
                    default: false
                    required: false
                    defaultHidden: true
                    order: 4

                duration:
                    label: 'Auto-Rotate Duration (seconds)'
                    description: 'If autoRotate is enabled, this controls the default interval to rotate to the next page. This value can be overridded at a page level.'
                    type: 'integer'
                    placeholder: 'Seconds per page'
                    default: 60
                    required: false
                    defaultHidden: true
                    order: 5

                preload:
                    label: 'Pre-Load Time (seconds)'
                    description: 'The amount of time, in seconds, before rotating to preload the next page. If set, this value will apply to all pages in the Dashboard. If autoRotate is false, this value is ignored.'
                    placeholder: 'Seconds'
                    type: 'integer'
                    default: 0.050
                    required: false
                    defaultHidden: true
                    order: 6

                allowFullscreen:
                    label: 'Allow Fullscreen'
                    description: 'If true, each Widget on a Page can be maximized to fill the entire Dashboard. This setting can be overridden by each Page/Widget.'
                    type: 'boolean'
                    default: true
                    required: false
                    defaultHidden: true

                openLinksInNewWindow:
                    label: 'Open Links in New Window'
                    description: 'If true, all links will open in a new browser window; this is the default.'
                    type: 'boolean'
                    required: false
                    default: true
                    defaultHidden: true

                showWidgetErrors:
                    label: 'Show Error Messages on Widgets'
                    description: 'If true, allows error messages to be displayed on Widgets. This setting can be overridden by each Page/Widget.'
                    type: 'boolean'
                    required: false
                    default: true
                    defaultHidden: true

                pages:
                    label: 'Pages'
                    description: 'The list of Page definitions which compose the Dashboard.'
                    type: 'pages'
                    default: []
                    required: true
                    properties:
                        name:
                            label: 'Name'
                            description: 'Name of this page; used in the browser title and URL.'
                            placeholder: 'Page Name'
                            type: 'string'
                            required: false
                            order: 0
                        layout:
                            label: 'Layout'
                            description: 'Contains properties for configuring the Page layout and dimensions.'
                            type: 'propertyset'
                            default: {}
                            required: false
                            properties:
                                gridColumns:
                                    label: 'Grid Columns'
                                    description: 'Specifies the total number of horizonal grid squares available in the grid. The grid squares will be scaled to fit the browser window. If omitted, the number of columns will be calculated dynamically.'
                                    type: 'integer'
                                    required: false
                                    order: 0
                                gridRows:
                                    label: 'Grid Rows'
                                    description: 'Specifies the total number of vertical grid squares available in the grid. The grid squares will be scaled vertically to fit the browser window. If omitted, the grid squares will be literally square, e.g. the height and width will be the same. When omitted, the widgets may not fill the entire browser window, or they may scroll vertically. Use this property to make widgets scale vertically to fit the dashboard.'
                                    type: 'integer'
                                    required: false
                                    order: 1
                                gutter:
                                    label: 'Gutter'
                                    description: 'Controls the space (in pixels) between widgets positioned in the grid. The default value is 10.'
                                    type: 'integer'
                                    default: 10
                                    required: false
                                    defaultHidden: true
                                    order: 2
                                borderWidth:
                                    label: 'Border Width'
                                    description: 'Specifies the pixel width of the border around each widget. Can be set to 0 to remove the border. If omitted, the theme default will be used.'
                                    type: 'integer'
                                    default: null
                                    required: false
                                    defaultHidden: true
                                    order: 3
                                margin:
                                    label: 'Margin'
                                    description: 'Controls the empty margin width (in pixels) around the outer edge of the Dashboard. Can be set to 0 to remove the margin.'
                                    type: 'integer'
                                    default: 10
                                    required: false
                                    defaultHidden: true
                                    order: 4
                            order: 2
                        widgets:
                            label: 'Widgets'
                            description: 'An array of one or more Widgets to display on the page'
                            type: 'propertyset[]'
                            subState: 'edit.widget'
                            headingfn: 'getWidgetName'
                            default: []
                            required: true
                            properties:
                                widget:
                                    label: 'Type'
                                    description: 'The type of Widget to be rendered.'
                                    type: 'string'
                                    required: true
                                name:
                                    label: 'Name'
                                    description: 'Internal Widget name, displayed in the Dashboard Editor.'
                                    placeholder: 'Name'
                                    type: 'string'
                                    required: false
                                    defaultHidden: true
                                    inlineJs: false
                                    order: 1
                                title:
                                    label: 'Title'
                                    description: 'Specifies the title of the widget. Most widgets will display the title at the top of the widget. If omitted, nothing will be displayed and the widget contents will occupy the entire widget boundaries.'
                                    placeholder: 'Widget Title'
                                    type: 'string'
                                    required: false
                                    inlineJs: true
                                    order: 2
                                gridHeight: 
                                    label: 'Grid Rows'
                                    description: 'Specifies the number of vertical grid squares for this widget to occupy. Instead of an absolute height, this sets the relative size based on grid units.'
                                    placeholder: 'Number of Rows'
                                    type: 'integer'
                                    default: '1'
                                    required: false
                                    order: 100
                                gridWidth:
                                    label: 'Grid Columns'
                                    description: 'Specifies the number of horizontal grid squares for this widget to occupy. Instead of an absolute width, this sets the relative size based on grid units.'
                                    placeholder: 'Number of Columns'
                                    type: 'integer'
                                    default: '1'
                                    required: false
                                    order: 101
                                theme:
                                    label: 'Theme'
                                    description: 'If set, overrides the Page theme and allows a widget to have a different theme from the rest of the Page and Widgets.'
                                    type: 'string'
                                    inherit: true
                                    required: false
                                    defaultHidden: true
                                    order: 102
                                noData:
                                    label: 'No Data Message'
                                    description: 'If set, displays this message in the Widget when no data is loaded from the Data Source. If not set, no message will be displayed'
                                    type: 'string'
                                    inlineJs: true
                                    required: false
                                    defaultHidden: true
                                    order: 103
                                noscroll: 
                                    label: 'No Scroll'
                                    description: 'If set to true, the widget will not have scrollbars and any overflow will be hidden. The effect of this setting varies per widget.'
                                    type: 'boolean'
                                    default: false
                                    required: false
                                    defaultHidden: true
                                    order: 104
                                allowFullscreen:
                                    label: 'Allow Fullscreen'
                                    description: 'If true, the Widget can be maximized to fill the entire Dashboard; if false, the ability to view in fullscreen is disabled. This property overrides the Page setting.'
                                    type: 'boolean'
                                    inherit: true
                                    required: false
                                    defaultHidden: true
                                    order: 105
                                showWidgetErrors:
                                    label: 'Show Error Messages on Widgets'
                                    description: 'If true, allows error messages to be displayed on Widgets. This property overrides the Page setting.'
                                    type: 'boolean'
                                    required: false
                                    inherit: true
                                    defaultHidden: true
                                    order: 106
                                hidden:
                                    label: 'Hidden'
                                    description: 'If true, the Widget will not be displayed in the Dashboard and will not occupy space in the Layout rendering. The Widget will still be initialized, however.'
                                    type: 'boolean'
                                    default: false
                                    required: false
                                    defaultHidden: true
                                    order: 107
                                height: 
                                    label: 'Height'
                                    description: 'If set, specifies the absolute display height of the widget. Any valid CSS value can be used (e.g. "200px", "40%", etc).'
                                    placeholder: 'Height'
                                    type: 'string'
                                    required: false
                                    defaultHidden: true
                                width:
                                    label: 'Width'
                                    description: 'If set, specifies the absolute display width of the widget. Any valid CSS value can be used (e.g. "200px", "40%", etc).'
                                    placeholder: 'Width'
                                    type: 'string'
                                    required: false
                                    defaultHidden: true

                            order: 3
                        duration:
                            label: 'Auto-Rotate Duration (seconds)'
                            description: 'The number of seconds to remain on this page before rotating to the next page. If autoRotate is set to false, this value is ignored.'
                            placeholder: 'Seconds per page'
                            inherit: true
                            type: 'integer'
                            required: false
                            defaultHidden: true
                            order: 4
                        frequency:
                            label: 'Frequency'
                            description: 'If greater than one, this page will only be shown on every N cycles through the dashboard. Defaults to 1, meaning the Page will be shown on every cycle.'
                            default: 1
                            type: 'integer'
                            required: false
                            defaultHidden: true
                            order: 5
                        theme:
                            label: 'Theme'
                            description: 'The theme for the Page. If not set, the Dashboard setting or default value will apply.'
                            type: 'string'
                            inherit: true
                            required: false
                            defaultHidden: true
                            order: 6
                        style:
                            label: 'Style'
                            description: 'The style for the Page. If not set, the Dashboard setting or default value will apply.'
                            type: 'string'
                            inherit: true
                            required: false
                            defaultHidden: true
                            order: 7
                        allowFullscreen:
                            label: 'Allow Fullscreen'
                            description: 'If true, each Widget on the page can be maximized to fill the entire Dashboard. This setting can be overridden by each Widget.'
                            type: 'boolean'
                            inherit: true
                            required: false
                            defaultHidden: true
                            order: 8
                        showWidgetErrors:
                            label: 'Show Error Messages on Widgets'
                            description: 'If true, allows error messages to be displayed on Widgets. This setting can be overridden by each Widget.'
                            type: 'boolean'
                            required: false
                            inherit: true
                            defaultHidden: true
                            order: 9;

                dataSources: 
                    label: 'Data Sources'
                    description: 'A list of Data Sources which connect to external services and pull in data for the Dashboard.'
                    type: 'datasources'
                    default: []
                    required: false
                    properties:
                        name:
                            label: 'Name'
                            description: 'The Data Source Name is used to reference the Data Source from a widget'
                            placeholder: 'Data Source Name'
                            type: 'string'
                            required: true
                            order: 1
                        type:
                            label: 'Type'
                            description: 'Specifies the implementation type of the Data Source'
                            type: 'string'
                            required: true
                            order: 0
                        filters: 
                            label: 'Filters'
                            description: 'Optional, but if provided, specifies name-value pairs used to filter the data source\'s result set. Each key specifies a column in the data source, and the value specifies either a single value (string) or a set of values (array of strings). Only rows which have the specifies value(s) will be permitted'
                            type: 'hash'
                            inlineJsKey: true
                            inlineJsValue: true
                            required: false
                            defaultHidden: true
                            order: 101
                        sortBy: 
                            label: 'Sort By'
                            description: 'Optional, specifies the field(s) to sort the data by. If the value is a string, it will sort by that single field. If it is an array of strings, multiple fields will be used to sort, with left-to-right priority. The column name can be prefixed with a + or a - sign to indicate the direction or sort. + is ascending, while - is descending. The default sort direction is ascending, so the + sign does not need to be used. If this property is omitted, the original sort order of the data will be used'
                            type: 'string[]'
                            inlineJs: true
                            required: false
                            placeholder: 'Column name'
                            defaultHidden: true
                            order: 102
                        preload:
                            label: 'Preload'
                            description: 'By default, each Data Source is loaded only when it is used, e.g. when a Widget consuming it is rendered. Setting this true causes Cyclotron to load the Data Source when the Dashboard is initialized.'
                            type: 'boolean'
                            inlineJs: false
                            required: false
                            default: false
                            defaultHidden: true
                            order: 103
                        deferred:
                            label: 'Deferred'
                            description: 'Prevents execution of the data source until execute() is manually called on the Data Source. This should only be used when using custom JavaScript to execute this Data Source, otherwise the Data Source will never run.'
                            type: 'boolean'
                            inlineJs: false
                            required: false
                            default: false
                            defaultHidden: true
                            order: 103
                    options:
                        json:
                            value: 'json'
                            icon: 'fa-cloud-download'
                            properties:
                                url:
                                    label: 'URL'
                                    description: 'Specifies the JSON Web Service URL.'
                                    placeholder: 'Web Service URL'
                                    type: 'url'
                                    inlineJs: true
                                    inlineEncryption: true
                                    required: true
                                    order: 10
                                queryParameters:
                                    label: 'Query Parameters'
                                    description: 'Optional query parameters which are added to the URL. If there are already query parameters in the URL, these will be appended. The keys and values are both URL-encoded.'
                                    type: 'hash'
                                    required: false
                                    inlineJsKey: true
                                    inlineJsValue: true
                                    inlineEncryption: true
                                    defaultHidden: true
                                    order: 12
                                options:
                                    label: 'Options'
                                    description: 'Optional request parameters that are passed to the library making the request.'
                                    type: 'hash'
                                    required: false
                                    inlineJsValue: true
                                    inlineEncryption: true
                                    defaultHidden: true
                                    order: 13
                                refresh: 
                                    label: 'Auto-Refresh'
                                    description: 'Optional; specifies the number of seconds after which the Data Source reloads'
                                    type: 'integer'
                                    required: false
                                    placeholder: 'Number of Seconds'
                                    order: 14
                                preProcessor:
                                    label: 'Pre-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the Data Source properties before it is executed. This method will be called before the Data Source is executed, and passed the Data Source object as an argument. This object can be modified, or a new/modified object returned. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    defaultHidden: true
                                    order: 15
                                postProcessor:
                                    label: 'Post-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the Crunch result before it is sent to the Widgets. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    order: 16
                                proxy:
                                    label: 'Proxy Server'
                                    description: 'Specifies which Proxy server to route the requests through. If omitted, the default proxy sever will be used.'
                                    type: 'url'
                                    inlineJs: true
                                    required: false
                                    defaultHidden: true
                                    order: 11
                        graphite:
                            value: 'graphite'
                            icon: 'fa-cloud-download'
                            message: 'The Graphite Data Source connects to any <a href="http://graphite.readthedocs.org/" target="_blank">Graphite<a> server to load time-series metrics via the Render api. For more details on usage, refer to the Graphite <a href="http://graphite.readthedocs.org/en/latest/render_api.html" target="_blank">documentation</a>.'
                            properties:
                                url:
                                    label: 'URL'
                                    description: 'The Graphite server'
                                    placeholder: 'Graphite Server URL or IP'
                                    type: 'url'
                                    inlineJs: true
                                    inlineEncryption: true
                                    required: true
                                    order: 10
                                targets:
                                    label: 'Targets'
                                    description: 'One or more Graphite metrics, optionally with metrics.'
                                    type: 'string[]'
                                    inlineJs: true
                                    inlineEncryption: true
                                    required: true
                                    order: 11
                                from:
                                    label: 'From'
                                    description: 'Specifies the absolute or relative beginning of the time period to retrieve. If omitted, it defaults to 24 hours ago (per Graphite).'
                                    placeholder: 'Start Time'
                                    type: 'string'
                                    inlineJs: true
                                    inlineEncryption: true
                                    required: false
                                    order: 12
                                until:
                                    label: 'Until'
                                    description: 'Specifies the absolute or relative end of the time period to retrieve. If omitted, it defaults now (per Graphite).'
                                    placeholder: 'End Time'
                                    type: 'string'
                                    inlineJs: true
                                    inlineEncryption: true
                                    required: false
                                    order: 13
                                refresh:
                                    label: 'Auto-Refresh'
                                    description: 'Optional; specifies the number of seconds after which the Data Source reloads'
                                    type: 'integer'
                                    required: false
                                    placeholder: 'Number of Seconds'
                                    order: 14
                                preProcessor:
                                    label: 'Pre-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the Data Source properties before it is executed. This method will be called before the Data Source is executed, and passed the Data Source object as an argument. This object can be modified, or a new/modified object returned. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    defaultHidden: true
                                    order: 15
                                postProcessor:
                                    label: 'Post-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the Graphite result before it is sent to the Widgets. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    order: 16
                                proxy:
                                    label: 'Proxy Server'
                                    description: 'Specifies which Proxy server to route the requests through. If omitted, the default proxy sever will be used.'
                                    type: 'url'
                                    inlineJs: true
                                    required: false
                                    defaultHidden: true
                                    order: 11
                        javascript: 
                            value: 'javascript'
                            icon: 'fa-cloud-download'
                            message: 'The JavaScript Data Source allows custom JavaScript to be used to load or generate a Data Source.'
                            properties: 
                                processor:
                                    label: 'Processor'
                                    description: 'Specifies a JavaScript function used to provide data for the Data Source, either by directly returning a data set, or resolving a promise asynchronously. The function is called with an optional promise which can be used for this purpose.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: true
                                    order: 10
                                refresh: 
                                    label: 'Auto-Refresh'
                                    description: 'Optional; specifies the number of seconds after which the Data Source reloads'
                                    type: 'integer'
                                    required: false
                                    placeholder: 'Number of Seconds'
                                    order: 11
                                preProcessor:
                                    label: 'Pre-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the Data Source properties before it is executed. This method will be called before the Data Source is executed, and passed the Data Source object as an argument. This object can be modified, or a new/modified object returned. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    defaultHidden: true
                                    order: 12
                                postProcessor:
                                    label: 'Post-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the JavaScript result dataset before it is sent to the Widgets. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    defaultHidden: true
                                    order: 13
                        mock: 
                            value: 'mock'
                            icon: 'fa-cloud-download'
                            message: 'The Mock Data Source generates sample data for testing a dashboard.'
                            properties:
                                format:
                                    label: 'Format'
                                    description: 'Selects the format of the mock data from these possible values: ["object", "pie", "ducati"]. Defaults to "object".'
                                    type: 'string'
                                    required: false
                                    default: 'object'
                                    options:
                                        object:
                                            value: 'object'
                                        pie:
                                            value: 'pie'
                                        large:
                                            value: 'large'
                                        ducati:
                                            value: 'ducati'
                                    order: 10
                                refresh: 
                                    label: 'Refresh'
                                    description: 'Optional; specifies the number of seconds after which the Data Source reloads'
                                    type: 'integer'
                                    required: false
                                    placeholder: 'Number of Seconds'
                                    order: 11
                        splunk: 
                            value: 'splunk'
                            icon: 'fa-cloud-download'
                            properties: 
                                query:
                                    label: 'Query'
                                    description: 'Splunk query'
                                    placeholder: 'Splunk query'
                                    type: 'textarea'
                                    required: true
                                    order: 10
                                earliest:
                                    label: 'Earliest Time'
                                    description: 'Sets the earliest (inclusive), respectively, time bounds for the search. The time string can be either a UTC time (with fractional seconds), a relative time specifier (to now) or a formatted time string.'
                                    placeholder: 'Earliest Time'
                                    type: 'string'
                                    inlineJs: true
                                    inlineEncryption: true
                                    required: false
                                    order: 11
                                latest:
                                    label: 'Latest Time'
                                    description: 'Sets the latest (exclusive), respectively, time bounds for the search. The time string can be either a UTC time (with fractional seconds), a relative time specifier (to now) or a formatted time string.'
                                    placeholder: 'Latest Time'
                                    type: 'string'
                                    inlineJs: true
                                    inlineEncryption: true
                                    required: false
                                    order: 12
                                username:
                                    label: 'Username'
                                    description: 'Username to authenticate with Splunk'
                                    type: 'string'
                                    required: true
                                    inlineJs: true
                                    inlineEncryption: true
                                    order: 13
                                password:
                                    label: 'Password'
                                    description: 'Password to authenticate with Splunk'
                                    type: 'string'
                                    required: true
                                    inlineJs: true
                                    inlineEncryption: true
                                    order: 14
                                host:
                                    label: 'Host'
                                    description: 'Splunk API host name'
                                    placeholder: 'Splunk API host name'
                                    type: 'string'
                                    inputType: 'string'
                                    required: false
                                    defaultHidden: false
                                    order: 15
                                url:
                                    label: 'URL'
                                    description: 'The Splunk API Search URL'
                                    placeholder: 'Splunk API Search URL'
                                    type: 'url'
                                    inlineJs: true
                                    inlineEncryption: true
                                    default: 'https://#{host}:8089/services/search/jobs/export'
                                    defaultHidden: true
                                    required: false
                                    order: 16
                                refresh: 
                                    label: 'Refresh'
                                    description: 'Optional; specifies the number of seconds after which the Data Source reloads'
                                    type: 'integer'
                                    required: false
                                    placeholder: 'Number of Seconds'
                                    order: 17
                                preProcessor:
                                    label: 'Pre-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the Data Source properties before it is executed. This method will be called before the Data Source is executed, and passed the Data Source object as an argument. This object can be modified, or a new/modified object returned. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    defaultHidden: true
                                    order: 18
                                postProcessor:
                                    label: 'Post-Processor'
                                    description: 'Specifies an optional JavaScript function that can inspect and modify the Splunk result dataset before it is sent to the Widgets. If this value is not an JavaScript function, it will be ignored.'
                                    placeholder: 'JavaScript Function'
                                    type: 'editor'
                                    editorMode: 'javascript'
                                    required: false
                                    defaultHidden: true
                                    order: 19
                                proxy:
                                    label: 'Proxy Server'
                                    description: 'Specifies which Proxy server to route the requests through. This is required to use encrypted strings within the Data Source properties. If omitted, the default proxy sever will be used.'
                                    type: 'url'
                                    inlineJs: true
                                    required: false
                                    defaultHidden: true
                                    order: 20

                parameters:
                    label: 'Parameters'
                    description: 'A list of Parameters that can be used to configure the Dashboard.'
                    type: 'propertyset[]'
                    default: []
                    required: false
                    properties: 
                        name:
                            label: 'Name'
                            description: 'The name used to set or reference this Parameter.'
                            type: 'string'
                            required: true
                            placeholder: 'Parameter Name'
                            order: 0
                        defaultValue:
                            label: 'Default Value'
                            description: 'The value used if the Parameter is not set when opening the Dashboard.'
                            type: 'string'
                            placeholder: 'Default Value'
                            required: false
                            inlineJs: true
                            order: 1
                        showInUrl:
                            label: 'Show in URL'
                            description: 'Determines whether or not the parameter value is displayed in the query string of the Dashboard URL.'
                            type: 'boolean'
                            required: false
                            order: 2
                            defaultValue: true
                    sample:
                        name: ''
                        defaultValue: ''

                scripts: 
                    label: 'Scripts'
                    description: 'Defines a list of inline JavaScript or external JavaScript URIs that are loaded when the Dashboard initializes.'
                    type: 'propertyset[]'
                    default: []
                    required: false
                    properties:
                        name:
                            label: 'Name'
                            description: 'Display name of the script'
                            type: 'string'
                            placeholder: 'Name'
                            required: false
                            order: 0
                        path:
                            label: 'Path'
                            description: 'URL to a JavaScript file, to be loaded along with the Dashboard'
                            type: 'url'
                            placeholder: 'JavaScript file URL'
                            required: false
                            order: 1
                        text:
                            label: 'JavaScript Text'
                            description: 'Inline JavaScript to be run when the Dashboard is loaded'
                            type: 'editor'
                            editorMode: 'javascript'
                            placeholder: 'Inline JavaScript'
                            required: false
                            order: 2
                        singleLoad:
                            label: 'Single-Load'
                            description: 'If true, this Script will only be loaded once when the Dashboard is loaded. Otherwise, it will be rerun every time the Dashboard internally refreshes. Scripts loaded from a path are always treated as single-load, and this property is ignored.'
                            type: 'boolean'
                            required: false
                            default: false
                            order: 3
                    sample:
                        text: ''

                styles: 
                    label: 'Styles'
                    description: 'Defines a list of inline CSS or external CSS URIs that are loaded when the Dashboard initializes.'
                    type: 'propertyset[]'
                    default: []
                    required: false
                    properties:
                        name:
                            label: 'Name'
                            description: 'Display name of the style'
                            type: 'string'
                            placeholder: 'Name'
                            required: false
                            order: 0
                        path:
                            label: 'Path'
                            description: 'URL to a CSS file, to be loaded along with the Dashboard'
                            type: 'url'
                            placeholder: 'CSS file URL'
                            required: false
                            order: 0
                        text:
                            label: 'CSS Text'
                            description: 'Inline CSS to be run when the Dashboard is loaded'
                            type: 'editor'
                            editorMode: 'css'
                            placeholder: 'Inline CSS'
                            required: false
                            order: 1
                    sample:
                        text: ''
            
            controls: 
                # Controls how long to display the controls before hiding.
                duration: 1000

                # Controls how close the mouse must be before the controls appear
                hitPaddingX: 60
                hitPaddingY: 50

            sample:
                name: ''

        # List of help pages
        help: [
            {
                name: 'About'
                path: '/partials/help/about.html'
                children: [
                    { name: 'Quick Start', path: '/partials/help/quickstart.html' }
                    { name: 'JSON', path: '/partials/help/json.html' }
                    { name: 'Examples', path: '/partials/help/examples.html' }
                    { name: 'Permissions', path: '/partials/help/permissions.html' }
                    { name: 'Encrypted Strings', path: '/partials/help/encryptedStrings.html' }
                    { name: 'Browser Compatibility', path: '/partials/help/browserCompat.html' }
                    { name: '3rd Party Libraries', path: '/partials/help/3rdparty.html' }
                    { name: 'Hotkeys', path: '/partials/help/hotkeys.html' }
                    { name: 'API', path: '/partials/help/api.html' }
                ]
            }
            {
                name: 'Dashboards'
                path: '/partials/help/dashboards.html'
                children: [
                    { name: 'Pages', path: '/partials/help/pages.html' }
                    { name: 'Layout', path: '/partials/help/layout.html' }
                    { name: 'Parameters', path: '/partials/help/parameters.html' }
                    { name: 'Scripts', path: '/partials/help/scripts.html' }
                    { name: 'Styles', path: '/partials/help/styles.html' }
                ]
            }
            {
                name: 'Data Sources'
                path: '/partials/help/dataSources.html'
            }
            {
                name: 'Widgets'
                path: '/partials/help/widgets.html'
            }
        ]

        # Formats supported for Dashboard Export
        exportFormats: [{
            label: 'PDF',
            value: 'pdf'
        }]

        # Page settings
        page: 
            sample: 
                frequency: 1
                layout: 
                    gridColumns: 2
                    gridRows: 2

                widgets: []

        # Widget settings
        widgets:
            chart:
                name: 'chart'
                icon: 'fa-bar-chart-o'
                properties:
                    dataSource:
                        label: 'Data Source'
                        description: 'The name of the Data Source providing data for this Widget.'
                        placeholder: 'Data Source name'
                        type: 'string'
                        required: true
                        options: datasourceOptions
                        order: 10
                    drilldownDataSource:
                        label: 'Drilldown Data Source'
                        description: 'The name of the Data Source providing drilldown data for this Widget.'
                        placeholder: 'Data Source name'
                        type: 'string'
                        required: false
                        defaultHidden: true
                        options: datasourceOptions
                        order: 11
                    highchart:
                        label: 'Highchart Definition'
                        description: 'Contains all the options for the chart, in the format expected by Highcharts. Any valid Highcharts properties can be set under this property and will be applied to the chart.'
                        type: 'json'
                        inlineJs: true
                        required: true
                        order: 12
                    filters: 
                        label: 'Filters'
                        description: 'Optional, but if provided, specifies name-value pairs used to filter the data source\'s result set. Each key specifies a column in the data source, and the value specifies either a single value (string) or a set of values (array of strings). Only rows which have the specifies value(s) will be permitted'
                        type: 'hash'
                        inlineJsKey: true
                        inlineJsValue: true
                        required: false
                        order: 13
                    sortBy: 
                        label: 'Sort By'
                        description: 'Optional, specifies the field(s) to sort the data by. If the value is a string, it will sort by that single field. If it is an array of strings, multiple fields will be used to sort, with left-to-right priority. The column name can be prefixed with a + or a - sign to indicate the direction or sort. + is ascending, while - is descending. The default sort direction is ascending, so the + sign does not need to be used. If this property is omitted, the original sort order of the data will be used'
                        type: 'string[]'
                        inlineJs: true
                        required: false
                        placeholder: 'Column name'
                        order: 14
                    addShiftPoints:
                        label: 'Add/Shift Points'
                        description: 'If true, identifies new points on each data reload and appends them to the right side of the chart, shifting points off of the left side. This is ideal for rolling time-series charts with a fixed number of points. The default is false, which forces a complete redraw of all points.'
                        type: 'boolean'
                        default: false
                        required: false
                        order: 15
                sample:
                    highchart:
                        series: [{
                                x: ''
                                y: ''
                            }
                        ]
                        xAxis: [{
                                type: 'linear'
                            }
                        ]
                        yAxis: [{
                                title:
                                    text: 'Values'
                            }
                        ]
                themes:
                    light:
                        chart:
                            style:
                                fontFamily: '"Open Sans", sans-serif'
                        drilldown:
                            activeAxisLabelStyle:
                                color: '#333'
                                textDecoration: 'none'
                        plotOptions: 
                            series: 
                                shadow: false
                                marker: 
                                    enabled: false
                                    states: 
                                        hover: 
                                            enabled: true
                            bar:
                                borderWidth: 0
                            column: 
                                borderWidth: 0
                            pie: 
                                borderWidth: 0
                        title:
                            style:
                                font: '16px "Lato", sans-serif'
                                fontWeight: 'bold'
                        subtitle:
                            style:
                                font: '12px "Lato", sans-serif'
                        xAxis:
                            gridLineWidth: 0
                            labels:
                                style:
                                    fontSize: '11px'
                            title:
                                style:
                                    fontSize: '14px'
                                    fontWeight: '300'
                        yAxis:
                            alternateGridColor: null
                            minorTickInterval: null
                            lineWidth: 0
                            tickWidth: 0
                            labels:
                                style:
                                    fontSize: '11px'
                            title:
                                style:
                                    fontSize: '14px'
                                    fontWeight: '300'
                        legend:
                            borderRadius: 0
                            borderWidth: 0
                            symbolWidth: 40

                    gto:
                        chart:
                            style:
                                fontFamily: '"Open Sans", sans-serif'
                        plotOptions:
                            series:
                                shadow: false
                                marker:
                                    enabled: false
                                    states:
                                        hover:
                                            enabled: true
                            bar:
                                borderWidth: 0
                            column:
                                borderWidth: 0
                            pie:
                                borderWidth: 0
                        title:
                            style:
                                font: '16px "Lato", sans-serif'
                                fontWeight: 'bold'
                        subtitle:
                            style:
                                font: '12px "Lato", sans-serif'
                        xAxis: 
                            gridLineWidth: 0
                            labels:
                                style:
                                    fontSize: '11px'
                            title:
                                style:
                                    fontSize: '14px'
                                    fontWeight: '300'
                        yAxis: 
                            alternateGridColor: null
                            minorTickInterval: null
                            lineWidth: 0
                            tickWidth: 0
                            labels: 
                                style:
                                    fontSize: '11px'
                            title:
                                style:
                                    fontSize: '14px'
                                    fontWeight: '300'
                        legend: 
                            borderRadius: 0
                            borderWidth: 0
                            symbolWidth: 40

                    dark: 
                        colors: [
                            '#007D9D' #Blue
                            '#82B93A' #Green
                            '#E3AAD5' #Pink
                            '#EBDC46' #Yellow
                            '#AC5B41' #Red
                            '#D1D1D0' #Offwhite
                            '#B07288'  #Purple
                        ]
                        chart: 
                            backgroundColor: null #'#333333'
                            borderWidth: 0
                            borderRadius: 0
                            plotBackgroundColor: null
                            plotShadow: false
                            plotBorderWidth: 0
                            style:
                                fontFamily: '"Open Sans", sans-serif'
                                color: '#FFF'
                        drilldown:
                            activeAxisLabelStyle:
                                color: '#999'
                                textDecoration: 'none'
                            activeDataLabelStyle:
                                color: '#999'
                                textDecoration: 'none'
                        title: 
                            style: 
                                color: '#FFF'
                                font: '16px "Lato", sans-serif'
                                fontWeight: 'bold'
                        subtitle: 
                            style:
                                color: '#FFF'
                                font: '12px "Lato", sans-serif'
                        xAxis:
                            gridLineWidth: 0
                            lineColor: '#999'
                            tickColor: '#999'
                            labels:
                                style:
                                    color: '#999'
                                    fontSize: '11px'
                            title:
                                style:
                                    color: '#EEE'
                                    fontSize: '14px'
                                    fontWeight: '300'
                        yAxis: 
                            alternateGridColor: null
                            minorTickInterval: null
                            gridLineColor: 'rgba(255, 255, 255, .1)'
                            minorGridLineColor: 'rgba(255,255,255,0.07)'
                            lineWidth: 0
                            tickWidth: 0
                            labels: 
                                style: 
                                    color: '#999'
                                    fontSize: '11px'
                            title: 
                                style: 
                                    color: '#EEE'
                                    fontSize: '14px'
                                    fontWeight: '300'
                        legend: 
                            borderRadius: 0
                            borderWidth: 0
                            itemStyle: 
                                color: '#CCC'
                            itemHoverStyle: 
                                color: '#FFF'
                            itemHiddenStyle: 
                                color: '#333'
                            symbolWidth: 40
                        labels: 
                            style:
                                color: '#CCC'
                        tooltip: 
                            backgroundColor: 
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0, 'rgba(96, 96, 96, .8)']
                                    [1, 'rgba(16, 16, 16, .8)']
                                ]
                            borderWidth: 0
                            style: 
                                color: '#FFF'
                        plotOptions:
                            series: 
                                dataLabels:
                                    style:
                                        color: '#999'
                                        textShadow: false
                                shadow: true
                                marker:
                                    enabled: false
                                    states:
                                        hover:
                                            enabled: true
                                dataLabels:
                                    style:
                                        color: '#999'
                                        textShadow: false
                            bar:
                                borderWidth: 0
                            column:
                                borderWidth: 0
                            line:
                                dataLabels:
                                    color: '#CCC'
                                marker: 
                                    lineColor: '#333'
                            pie: 
                                borderWidth: 0
                                dataLabels: 
                                    color: '#999'
                                    fontSize: '14px'
                            spline:
                                marker:
                                    lineColor: '#333'
                            scatter: 
                                marker:
                                    lineColor: '#333'
                            candlestick:
                                lineColor: 'white'

                        toolbar:
                            itemStyle:
                                color: '#CCC'
                            
                        navigation: 
                            buttonOptions: 
                                symbolStroke: '#DDDDDD'
                                hoverSymbolStroke: '#FFFFFF'
                                theme: 
                                    fill: 
                                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                        stops: [
                                            [0.4, '#606060']
                                            [0.6, '#333333']
                                        ]
                                    stroke: '#000000'

                        # scroll charts
                        rangeSelector: 
                            buttonTheme: 
                                fill: 
                                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                    stops: [
                                        [0.4, '#888']
                                        [0.6, '#555']
                                    ]
                                stroke: '#000000'
                                style: 
                                    color: '#CCC'
                                    fontWeight: 'bold'
                                states: 
                                    hover: 
                                        fill: 
                                            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                            stops: [
                                                [0.4, '#BBB']
                                                [0.6, '#888']
                                            ]
                                        stroke: '#000000'
                                        style: 
                                            color: 'white'
                                    select: 
                                        fill: 
                                            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                            stops: [
                                                [0.1, '#000']
                                                [0.3, '#333']
                                            ]
                                        stroke: '#000000'
                                        style:
                                            color: 'yellow'
                            inputStyle: 
                                backgroundColor: '#333'
                                color: 'silver'
                            labelStyle: 
                                color: 'silver'
                            
                        navigator: 
                            handles: 
                                backgroundColor: '#666'
                                borderColor: '#AAA'
                            outlineColor: '#CCC'
                            maskFill: 'rgba(16, 16, 16, 0.5)'
                            series: 
                                color: '#7798BF'
                                lineColor: '#A6C7ED'

                        scrollbar: 
                            barBackgroundColor: 
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0.4, '#888']
                                    [0.6, '#555']
                                ]
                            barBorderColor: '#CCC'
                            buttonArrowColor: '#CCC'
                            buttonBackgroundColor: 
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0.4, '#888']
                                    [0.6, '#555']
                                ]
                            buttonBorderColor: '#CCC'
                            rifleColor: '#FFF'
                            trackBackgroundColor: 
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0, '#000']
                                    [1, '#333']
                                ]
                            trackBorderColor: '#666'

                    dark2:  
                        colors: [
                            '#2095F0' #Blue
                            '#FF9A13' #Orange
                            '#FFFF13' #Yellow
                            '#A61DF1' #Purple
                            '#28F712' #Green
                            '#FE131E' #Red
                            '#D1D1D0' #Offwhite
                        ]
                        chart: 
                            backgroundColor: null #'#333333'
                            borderWidth: 0
                            borderRadius: 0
                            plotBackgroundColor: null
                            plotShadow: false
                            plotBorderWidth: 0
                            style: 
                                fontFamily: '"Open Sans", sans-serif'
                                color: '#FFF'
                        drilldown:
                            activeAxisLabelStyle:
                                color: '#999'
                                textDecoration: 'none'
                            activeDataLabelStyle:
                                color: '#999'
                                textDecoration: 'none'
                        title: 
                            style: 
                                color: '#FFF'
                                font: '16px "Lato", sans-serif'
                                fontWeight: 'bold'
                        subtitle: 
                            style:
                                color: '#FFF'
                                font: '12px "Lato", sans-serif'

                        xAxis:
                            gridLineWidth: 0
                            lineColor: '#999'
                            tickColor: '#999'
                            labels:
                                style:
                                    color: '#999'
                                    fontSize: '11px'
                            title:
                                style:
                                    color: '#EEE'
                                    fontSize: '14px'
                                    fontWeight: '300'

                        yAxis:
                            alternateGridColor: null
                            minorTickInterval: null
                            gridLineColor: 'rgba(255, 255, 255, .1)'
                            minorGridLineColor: 'rgba(255,255,255,0.07)'
                            lineWidth: 0
                            tickWidth: 0
                            labels:
                                style:
                                    color: '#999'
                                    fontSize: '11px'
                            title:
                                style:
                                    color: '#EEE'
                                    fontSize: '14px'
                                    fontWeight: '300'
                        legend: 
                            borderRadius: 0
                            borderWidth: 0
                            itemStyle:
                                color: '#CCC'
                            itemHoverStyle:
                                color: '#FFF'
                            itemHiddenStyle:
                                color: '#333'
                            symbolWidth: 40
                        labels:
                            style:
                                color: '#CCC'
                        tooltip:
                            backgroundColor:
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0, 'rgba(96, 96, 96, .8)']
                                    [1, 'rgba(16, 16, 16, .8)']
                                ]
                            borderWidth: 0
                            style:
                                color: '#FFF'
                        plotOptions:
                            series:
                                shadow: true
                                marker:
                                    enabled: false
                                    states:
                                        hover:
                                            enabled: true
                                dataLabels:
                                    style:
                                        color: '#999'
                                        textShadow: false
                            bar:
                                borderWidth: 0
                            column:
                                borderWidth: 0
                            line: 
                                dataLabels: 
                                    color: '#CCC'
                                marker:
                                    lineColor: '#333'
                            pie:
                                borderWidth: 0
                                dataLabels:
                                    color: '#999'
                                    fontSize: '14px'
                            spline:
                                marker:
                                    lineColor: '#333'
                            scatter:
                                marker:
                                    lineColor: '#333'
                            candlestick:
                                lineColor: 'white'

                        toolbar: 
                            itemStyle: 
                                color: '#CCC'

                        navigation: 
                            buttonOptions: 
                                symbolStroke: '#DDDDDD'
                                hoverSymbolStroke: '#FFFFFF'
                                theme: 
                                    fill: 
                                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                        stops: [
                                            [0.4, '#606060']
                                            [0.6, '#333333']
                                        ]
                                    stroke: '#000000'

                        # scroll charts
                        rangeSelector:
                            buttonTheme:
                                fill:
                                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                    stops: [
                                        [0.4, '#888']
                                        [0.6, '#555']
                                    ]
                                stroke: '#000000'
                                style:
                                    color: '#CCC'
                                    fontWeight: 'bold'
                                states:
                                    hover:
                                        fill:
                                            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                            stops: [
                                                [0.4, '#BBB']
                                                [0.6, '#888']
                                            ]
                                        stroke: '#000000'
                                        style:
                                            color: 'white'
                                    select: 
                                        fill:
                                            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                            stops: [
                                                [0.1, '#000']
                                                [0.3, '#333']
                                            ]
                                        stroke: '#000000'
                                        style:
                                            color: 'yellow'
                            inputStyle:
                                backgroundColor: '#333'
                                color: 'silver'
                            labelStyle:
                                color: 'silver'

                        navigator:
                            handles:
                                backgroundColor: '#666'
                                borderColor: '#AAA'
                            outlineColor: '#CCC'
                            maskFill: 'rgba(16, 16, 16, 0.5)'
                            series:
                                color: '#7798BF'
                                lineColor: '#A6C7ED'
                            
                        scrollbar: 
                            barBackgroundColor:
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0.4, '#888']
                                    [0.6, '#555']
                                ]
                            barBorderColor: '#CCC'
                            buttonArrowColor: '#CCC'
                            buttonBackgroundColor: 
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0.4, '#888']
                                    [0.6, '#555']
                                ]
                            buttonBorderColor: '#CCC'
                            rifleColor: '#FFF'
                            trackBackgroundColor: 
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }
                                stops: [
                                    [0, '#000']
                                    [1, '#333']
                                ]
                            trackBorderColor: '#666'
                        
            clock:
                name: 'clock'
                icon: 'fa-clock-o'
                properties:
                    format:
                        label: 'Format'
                        description: 'Enter time format of your choice. "http://momentjs.com/docs/#/displaying/format/" can help in choosing time formats'
                        type: 'string'
                        required: false
                        order: 10

            html:
                name: 'html'
                icon: 'fa-html5'
                properties:
                    dataSource:
                        label: 'Data Source'
                        description: 'Optional; the name of the Data Source providing data for this Widget. If set, the `html` property will be used as a repeater and rendered once for each row.'
                        placeholder: 'Data Source name'
                        type: 'string'
                        required: false
                        options: datasourceOptions
                        order: 10
                    html:
                        label: 'HTML'
                        description: 'Contains HTML markup to be displayed. If dataSource is set, this HTML will be repeated for each row in the result.'
                        type: 'editor'
                        editorMode: 'html'
                        required: false
                        default: ''
                        order: 11
                    preHtml:
                        label: 'Pre-HTML'
                        description: 'Optional, contains HTML markup which is displayed before the main body of HTML.'
                        type: 'editor'
                        editorMode: 'html'
                        required: false
                        default: ''
                        order: 12
                    postHtml:
                        label: 'Post-HTML'
                        description: 'Optional, contains HTML markup which is displayed after the main body of HTML.'
                        type: 'editor'
                        editorMode: 'html'
                        required: false
                        default: ''
                        order: 13
                    filters: 
                        label: 'Filters'
                        description: 'Optional, but if provided, specifies name-value pairs used to filter the data source\'s result set. Each key specifies a column in the data source, and the value specifies either a single value (string) or a set of values (array of strings). Only rows which have the specifies value(s) will be permitted.'
                        type: 'hash'
                        inlineJsKey: true
                        inlineJsValue: true
                        required: false
                        order: 14
                    sortBy: 
                        label: 'Sort By'
                        description: 'Optional, specifies the field(s) to sort the data by. If the value is a string, it will sort by that single field. If it is an array of strings, multiple fields will be used to sort, with left-to-right priority. The column name can be prefixed with a + or a - sign to indicate the direction or sort. + is ascending, while - is descending. The default sort direction is ascending, so the + sign does not need to be used. If this property is omitted, the original sort order of the data will be used.'
                        placeholder: 'Column name'
                        type: 'string[]'
                        inlineJs: true
                        required: false                        
                        order: 15
                
            iframe:
                name: 'iframe'
                icon: 'fa-desktop'
                properties:
                    url:
                        label: 'Url'
                        description: 'Specifies the URL to be loaded within the Widget.'
                        type: 'string'
                        placeholder: 'Url'
                        required: true
                        default: 'http://www.expedia.com'
                        order: 10
                    refresh: 
                        label: 'Refresh'
                        description: 'Optional; enables reloading the iframe contents periodically every N seconds.'
                        placeholder: 'Seconds'
                        type: 'integer'
                        required: false
                        order: 11
                
            javascript:
                name: 'javascript'
                icon: 'fa-cogs'
                properties:
                    dataSource:
                        label: 'Data Source'
                        description: 'Optional; the name of the Data Source providing data for this Widget. If set, the data source will be called and the result will be passed to the JavaScript function.'
                        placeholder: 'Data Source name'
                        type: 'string'
                        required: false
                        options: datasourceOptions
                        order: 10
                    functionName:
                        label: 'Function Name'
                        description: 'JavaScript function name used to create a controller instance. Supports namespaces/drilldown using periods, e.g. Cyclotron.functions.scatterPlot'
                        placeholder: 'Function Name'
                        type: 'string'
                        required: true
                        order: 11
                    refresh: 
                        label: 'Refresh'
                        description: 'Optional; enables re-invoking the javascript object periodically every N seconds.'
                        placeholder: 'Seconds'
                        type: 'integer'
                        required: false
                        order: 12
                    filters: 
                        label: 'Filters'
                        description: 'Optional, but if provided, specifies name-value pairs used to filter the data source\'s result set. Each key specifies a column in the data source, and the value specifies either a single value (string) or a set of values (array of strings). Only rows which have the specifies value(s) will be permitted.'
                        type: 'hash'
                        inlineJsKey: true
                        inlineJsValue: true
                        required: false
                        order: 13
                    sortBy: 
                        label: 'Sort By'
                        description: 'Optional, specifies the field(s) to sort the data by. If the value is a string, it will sort by that single field. If it is an array of strings, multiple fields will be used to sort, with left-to-right priority. The column name can be prefixed with a + or a - sign to indicate the direction or sort. + is ascending, while - is descending. The default sort direction is ascending, so the + sign does not need to be used. If this property is omitted, the original sort order of the data will be used.'
                        placeholder: 'Column name'
                        type: 'string[]'
                        inlineJs: true
                        required: false                        
                        order: 14

            number: 
                name: 'number'
                icon: 'fa-cog'
                properties:
                    dataSource:
                        label: 'Data Source'
                        description: 'Optional, but required to use data expressions e.g. "#{columnName}". The name of the Data Source providing data for this Widget.'
                        placeholder: 'Data Source Name'
                        type: 'string'
                        required: false
                        options: datasourceOptions
                        order: 10
                    numbers:
                        label: 'Numbers'
                        singleLabel: 'number'
                        description: 'One or more Numbers to display in this widget.'
                        type: 'propertyset[]'
                        required: true
                        default: []
                        order: 11
                        properties:
                            number:
                                label: 'Number'
                                description: 'Number value or expression.'
                                placeholder: 'Value'
                                inlineJs: true
                                required: false
                                type: 'string'
                                order: 1
                            prefix:
                                label: 'Prefix'
                                description: 'Optional; specifies a prefix to append to the number.'
                                placeholder: 'Prefix'
                                type: 'string'
                                inlineJs: true
                                order: 2
                            suffix:
                                label: 'Suffix'
                                description: 'Optional; specifies a suffix to append to the number.'
                                placeholder: 'Suffix'
                                type: 'string'
                                inlineJs: true
                                order: 3
                            color:
                                label: 'Color'
                                description: 'Sets the color of the number.'
                                placeholder: 'Color'
                                type: 'string'
                                inlineJs: true
                                required: false
                                defaultHidden: true
                            tooltip:
                                label: 'Tooltip'
                                description: 'Sets the tooltip of the number.'
                                placeholder: 'Tooltip'
                                type: 'string'
                                inlineJs: true
                                required: false
                                defaultHidden: true
                            icon:
                                label: 'Icon'
                                description: 'Optional Font Awesome icon class to be displayed with the number.'
                                placeholder: 'Icon Class'
                                inlineJs: true
                                type: 'string'
                                defaultHidden: true
                            iconColor:
                                label: 'Icon Color'
                                description: 'Optionally specifies a color for the icon if the icon property is also set. The value can be a named color (e.g. "red"), a hex color (e.g. "#AA0088") or a data source column/inline javascript (e.g. "#{statusColor}").'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            iconTooltip:
                                label: 'IconTooltip'
                                description: 'Sets the tooltip of the icon.'
                                placeholder: 'Icon Tooltip'
                                type: 'string'
                                inlineJs: true
                                required: false
                                defaultHidden: true
                    orientation:
                        label: 'Orientation'
                        description: 'Controls the direction in which the numbers are arranged.'
                        type: 'string'
                        required: false
                        default: 'vertical'
                        options:
                            vertical:
                                value: 'vertical'
                            horizontal:
                                value: 'horizontal'
                        order: 12
                    link:
                        label: 'Link'
                        description: 'Optional, specifies a URL that will be displayed at the bottom of the widget as a link.'
                        placeholder: 'URL'
                        type: 'url'
                        required: false
                        order: 13

                    filters: 
                        label: 'Filters'
                        description: "Optional, but if provided, specifies name-value pairs used to filter the data source's result set. This has no effect if the dataSource property is not set.\nOnly the first row of the data source is used to get data, so this property can be used to narrow down on the correct row"
                        type: 'hash'
                        inlineJsKey: true
                        inlineJsValue: true
                        required: false
                        order: 15
                    sortBy: 
                        label: 'Sort By'
                        description: 'Optional, specifies the field(s) to sort the data by. If the value is a string, it will sort by that single field. If it is an array of strings, multiple fields will be used to sort, with left-to-right priority. The column name can be prefixed with a + or a - sign to indicate the direction or sort. + is ascending, while - is descending. The default sort direction is ascending, so the + sign does not need to be used. If this property is omitted, the original sort order of the data will be used.\nOnly the first row of the data source is used to get data, so this property can be used to sort the data and ensure the correct row comes first.'
                        type: 'string[]'
                        inlineJs: true
                        required: false
                        placeholder: 'Column name'
                        order: 16

            stoplight:
                name: 'stoplight'
                icon: 'fa-cog'
                properties:
                    dataSource:
                        label: 'Data Source'
                        description: 'The name of the Data Source providing data for this Widget.'
                        placeholder: 'Data Source Name'
                        type: 'string'
                        required: false
                        options: datasourceOptions
                        order: 10
                    rules:
                        label: 'Rules'
                        description: 'Contains rule expressions for the different states of the Stoplight. The rules will be evaluated from red to green, and only the first rule that returns true will be enabled'
                        type: 'propertyset'
                        required: true
                        order: 11
                        properties:
                            green:
                                label: 'Green'
                                description: 'The rule expression evaluated to determine if the green light is active. It should be an inline JavaScript expression, e.g. ${true}. It can contain column values using #{name} notation, which will be replaced before executing the JavaScript. It should return true or false, and any non-true value will be treated as false.'
                                type: 'string'
                                placeholder: 'Rule Expression'
                                inlineJs: true
                                order: 3
                            yellow:
                                label: 'Yellow'
                                description: 'The rule expression evaluated to determine if the yellow light is active. It should be an inline JavaScript expression, e.g. ${true}. It can contain column values using #{name} notation, which will be replaced before executing the JavaScript. It should return true or false, and any non-true value will be treated as false.'
                                type: 'string'
                                placeholder: 'Rule Expression'
                                inlineJs: true
                                order: 2
                            red:
                                label: 'Red'
                                description: 'The rule expression evaluated to determine if the red light is active. It should be an inline JavaScript expression, e.g. ${true}. It can contain column values using #{name} notation, which will be replaced before executing the JavaScript. It should return true or false, and any non-true value will be treated as false.'
                                type: 'string'
                                placeholder: 'Rule Expression'
                                inlineJs: true
                                order: 1
                    filters: 
                        label: 'Filters'
                        description: "Optional, but if provided, specifies name-value pairs used to filter the data source's result set. This has no effect if the dataSource property is not set.\nOnly the first row of the data source is used to get data, so this property can be used to narrow down on the correct row"
                        type: 'hash'
                        inlineJsKey: true
                        inlineJsValue: true
                        required: false
                        order: 15
                    sortBy: 
                        label: 'Sort By'
                        description: 'Optional, specifies the field(s) to sort the data by. If the value is a string, it will sort by that single field. If it is an array of strings, multiple fields will be used to sort, with left-to-right priority. The column name can be prefixed with a + or a - sign to indicate the direction or sort. + is ascending, while - is descending. The default sort direction is ascending, so the + sign does not need to be used. If this property is omitted, the original sort order of the data will be used.\nOnly the first row of the data source is used to get data, so this property can be used to sort the data and ensure the correct row comes first.'
                        type: 'string[]'
                        inlineJs: true
                        required: false
                        placeholder: 'Column name'
                        order: 16

            table: 
                name: 'table'
                icon: 'fa-table'
                properties:
                    dataSource:
                        label: 'Data Source'
                        description: 'The name of the Data Source providing data for this Widget.'
                        placeholder: 'Data Source name'
                        type: 'string'
                        required: true
                        options: datasourceOptions
                        order: 10
                    columns:
                        label: 'Columns'
                        singleLabel: 'column'
                        description: 'Specifies the columns to display in the table, and their properties. If omitted, the columns will be automatically determined, either using a list of fields provided by the data source, or by looking at the first row.'
                        type: 'propertyset[]'
                        inlineJs: true
                        properties:
                            name:
                                label: 'Name'
                                description: 'Indicates the name of the data source field to use for this column.'
                                type: 'string'
                                inlineJs: true
                                order: 1
                            label:
                                label: 'Label'
                                description: 'If provided, sets the header text for the column. If omitted, the name will be used. "#value" can be used to reference the "name" property of the column.'
                                type: 'string'
                                inlineJs: true
                                order: 2
                            text:
                                label: 'Text'
                                description: 'Overrides the text in the cell using this value as an expression.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                                order: 3
                            tooltip:
                                label: 'Tooltip'
                                description: 'Optionally specifies a tooltip to display for each cell in the column.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            headerTooltip:
                                label: 'Header Tooltip'
                                description: 'Optionally specifies a tooltip to display for the column header. "#value" can be used to reference the "name" property of the column.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            link:
                                label: 'Link'
                                description: 'If provided, the cell text will be made into a link rather than plain text.'
                                type: 'url'
                                inlineJs: true
                                defaultHidden: true
                            openLinksInNewWindow:
                                label: 'Open Links in New Window'
                                description: 'If true, links will open in a new browser window; this is the default.'
                                type: 'boolean'
                                default: true
                                defaultHidden: true
                            numeralformat:
                                label: 'Numeral Format'
                                description: 'Optionally specifies a Numeral.js-compatible format string, used to reformat the column value for display.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            image:
                                label: 'Image'
                                description: 'Optionally specifies a URL to an image to display in the column. The URL can be parameterized using any column values.'
                                type: 'url'
                                inlineJs: true
                                defaultHidden: true
                            imageHeight:
                                label: 'Image Height'
                                description: 'Optionally sets the height for the images displayed using the image property. If omitted, each image will be displayed at "1em" (the same height as text in the cell). Any valid CSS value string can be used, e.g. "110%", "20px", etc.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            icon:
                                label: 'Icon'
                                description: 'Optionally specifies a Font Awesome icon class to be displayed in the cell.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            iconColor:
                                label: 'Icon Color'
                                description: 'Optionally specifies a color for the icon if the icon property is also set. The value can be a named color (e.g. "red"), a hex color (e.g. "#AA0088") or a data source column/inline javascript (e.g. "#{statusColor}").'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            border:
                                label: 'Border'
                                description: 'Optionally draws a border on either or both sides of the column. If set, this value should be either "left", "right", or "left,right" to indicate on which sides of the column to draw the borders.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            group:
                                label: 'Column Group'
                                description: 'Optionally puts the column in a column group. The value must be a string, which will be displayed above all consecutive columns with the same group property. The column group row will not appear unless at least one column has a group specified.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            groupRows:
                                label: 'Group Rows'
                                description: 'Optionally combines identical, consecutive values within a column. If set to true, and depending on the sort, repeated values in a column will be combined into a single cell with its rowspan value set. If the rows are separated by a resort, the combined cells will be split apart again. This property can be applied to any column(s) in the table. The default value is false.'
                                type: 'boolean'
                                default: false
                                defaultHidden: true
                            columnSortFunction:
                                label: 'Column Sort Function'
                                description: 'When using wildcard or regex expression in the `name` field, this property optionally provides a sort function used to order the generated columns. This function takes an array of column names and can return a sorted (or modified) array. Example: "${function(columns){return _.sortBy(columns);}}".'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            columnsIgnored:
                                label: 'Columns Ignored'
                                description: 'When using wildcard or regex expression in the `name` field, this can contain a list of one or more column names that should not be matched.'
                                type: 'string[]'
                                required: false
                                inlineJs: false
                                defaultHidden: true
                        order: 10
                        sample:
                            name: ''
                    rules:
                        label: 'Rules'
                        singleLabel: 'rule'
                        description: 'Specifies an array of rules that will be run on each row in the table. Style properties can be set for every matching rule, on either the entire row or a subset of columns.'
                        type: 'propertyset[]'
                        inlineJs: true
                        properties:
                            rule:
                                label: 'Rule'
                                description: 'The rule expression evaluated to determine if this rule applies to a row. It can contain column values using #{name} notation. It will be evaluated as javascript, and should return true or false.'
                                type: 'string'
                                required: true
                                inlineJs: true
                                order: 1
                            columns:
                                label: 'Columns Affected'
                                description: 'Optionally specifies an array of column names, limiting the rule\'s effect to only the cells specified, rather than the entire row.'
                                type: 'string[]'
                                required: false
                                order: 2
                            columnsIgnored:
                                label: 'Columns Ignored'
                                description: 'Optionally specifies an array of column names that the rule does NOT apply to.'
                                type: 'string[]'
                                required: false
                                order: 3
                            name:
                                label: 'Name'
                                description: 'Indicates the name of the data source field to use for this column.'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            'font-weight':
                                label: 'Font-Weight (CSS)'
                                description: 'CSS setting for `font-weight`'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            color:
                                label: 'Color (CSS)'
                                description: 'CSS setting for `color`'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                            'background-color':
                                label: 'Background Color (CSS)'
                                description: 'CSS setting for `background-color`'
                                type: 'string'
                                inlineJs: true
                                defaultHidden: true
                        order: 11
                        sample:
                            rule: 'true'
                    freezeHeaders:
                        label: 'Freeze Headers'
                        description: 'Enables frozen headers at the top of the widget when scrolling'
                        type: 'boolean'
                        default: false
                        required: false
                        order: 12
                    omitHeaders:
                        label: 'Omit Headers'
                        description: 'Disables the table header row'
                        type: 'boolean'
                        default: false
                        required: false
                        order: 13
                    enableSort:
                        label: 'Enable Sort'
                        description: 'Enable or disable user sort controls'
                        type: 'boolean'
                        default: true
                        required: false
                        order: 14
                    filters: 
                        label: 'Filters'
                        description: 'Optional, but if provided, specifies name-value pairs used to filter the data source\'s result set. Each key specifies a column in the data source, and the value specifies either a single value (string) or a set of values (array of strings). Only rows which have the specifies value(s) will be permitted.'
                        type: 'hash'
                        inlineJsKey: true
                        inlineJsValue: true
                        required: false
                        order: 15
                    sortBy: 
                        label: 'Sort By'
                        description: 'Optional, specifies the field(s) to sort the data by. If the value is a string, it will sort by that single field. If it is an array of strings, multiple fields will be used to sort, with left-to-right priority. The column name can be prefixed with a + or a - sign to indicate the direction or sort. + is ascending, while - is descending. The default sort direction is ascending, so the + sign does not need to be used. If this property is omitted, the original sort order of the data will be used.'
                        type: 'string[]'
                        inlineJs: true
                        required: false
                        placeholder: 'Column name'
                        order: 16
                    sortFunction:
                        label: 'Sort Function'
                        description: 'Optional, specifies an alternative function to the default sort implementation.'
                        placeholder: 'JavaScript Function'
                        type: 'editor'
                        editorMode: 'javascript'
                        required: false
                        defaultHidden: true
                        order: 17

            tableau: 
                name: 'tableau'
                icon: 'fa-cog'
                properties: 
                    params:
                        label: 'Parameters'
                        description: 'An object of key-value pairs that Tableau uses to render the report. These parameters are specific to Tableau and will be passed-through to the view.'
                        type: 'hash'
                        required: true
                        editorMode: 'json'
                        order: 10
        
            treemap:
                name: 'treemap'
                icon: 'fa-tree'
                properties:
                    dataSource:
                        label: 'Data Source'
                        description: 'The name of the Data Source providing data for this Widget.'
                        placeholder: 'Data Source name'
                        type: 'string'
                        required: true
                        options: datasourceOptions
                        order: 10
                    labelProperty:
                        label: 'Label Property'
                        description: 'The name of the property to use as the label of each item.'
                        type: 'string'
                        inlineJs: true
                        required: false
                        default: 'name'
                        defaultHidden: true
                        order: 11
                    valueProperty:
                        label: 'Value Property'
                        description: 'The name of the property to use to calculate the size of each item.'
                        type: 'string'
                        inlineJs: true
                        required: false
                        default: 'value'
                        defaultHidden: true
                        order: 12
                    valueDescription:
                        label: 'Value Description'
                        description: 'A short description of the property used to calculate the size of each item. Used in tooltips.'
                        type: 'string'
                        inlineJs: true
                        required: false
                        defaultHidden: true
                        order: 13
                    valueFormat:
                        label: 'Value Format'
                        description: 'Specifies a Numeral.js-compatible format string used to format the label of the size value.'
                        type: 'string'
                        default: ',.2f'
                        required: false
                        defaultHidden: true
                        inlineJs: true
                        options: 
                            default:
                                value: '0,0.[0]'
                            percent:
                                value: '0,0%'
                            integer:
                                value: '0,0'
                            currency:
                                value: '$0,0'
                        order: 14
                    colorProperty:
                        label: 'Color Property'
                        description: 'The name of the property to use to calculate the color of each item. If omitted, the TreeMap will not be colored.'
                        type: 'string'
                        inlineJs: true
                        required: false
                        default: 'color'
                        order: 15
                    colorDescription:
                        label: 'Color Description'
                        description: 'A short description of the property used to calculate the color of each item. Used in tooltips.'
                        type: 'string'
                        inlineJs: true
                        required: false
                        defaultHidden: true
                        order: 16
                    colorFormat:
                        label: 'Color Format'
                        description: 'Specifies a Numeral.js-compatible format string used to format the label of the color value.'
                        type: 'string'
                        default: ',.2f'
                        required: false
                        defaultHidden: true
                        inlineJs: true
                        options: 
                            default:
                                value: '0,0.[0]'
                            percent:
                                value: '0,0%'
                            integer:
                                value: '0,0'
                            currency:
                                value: '$0,0'
                            large:
                                value: '0a'
                        order: 17
                    colorStops:
                        label: 'Color Stops'
                        singleLabel: 'color'
                        description: 'Specifies a list of color stops used to build a gradient.'
                        type: 'propertyset[]'
                        inlineJs: true
                        properties:
                            value:
                                label: 'Value'
                                description: 'The numerical value assigned to this color stop.'
                                type: 'number'
                                required: true
                                inlineJs: true
                                order: 1
                            color:
                                label: 'Color'
                                description: 'The color to display at this color stop. Hex codes or CSS colors are permitted.'
                                type: 'string'
                                required: false
                                inlineJs: true
                                order: 2
                        order: 18
                    showLegend:
                        label: 'Show Legend'
                        description: 'Enables or disables the color legend.'
                        type: 'boolean'
                        default: true
                        required: false
                        order: 19
                    legendHeight:
                        label: 'Legend Height'
                        description: 'Specifies the height of the legend in pixels.'
                        type: 'number'
                        default: 30
                        required: false
                        defaultHidden: true
                        order: 20
    }  


    # Copy Theme options to inherited locations
    exports.dashboard.properties.pages.properties.theme.options = exports.dashboard.properties.theme.options
    exports.dashboard.properties.pages.properties.widgets.properties.theme.options = exports.dashboard.properties.theme.options

    # Copy Style options to inherited locations
    exports.dashboard.properties.pages.properties.style.options = exports.dashboard.properties.style.options


    # Table Widget: Column properties duplicated in Rules:
    tableProperties = exports.widgets.table.properties
    _.defaults tableProperties.rules.properties, _.omit(tableProperties.columns.properties, 'label')

    # Copy some chart themes
    exports.widgets.chart.themes.lightborderless = exports.widgets.chart.themes.light

    # Add Widget and Data Source help pages
    _.find(exports.help, { name: 'Data Sources' }).children = _.map _.sortBy(exports.dashboard.properties.dataSources.options, 'name'), (dataSource) ->
        { name: dataSource.value, path: '/partials/help/datasources/' + dataSource.value + '.html' }

    _.find(exports.help, { name: 'Widgets' }).children = _.map _.sortBy(exports.widgets, 'name'), (widget) ->
        { name: widget.name, path: '/widgets/' + widget.name + '/help.html' }

    return exports

