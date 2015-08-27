# GoogleVisualr

[![Gem Version](http://img.shields.io/gem/v/google_visualr.svg?style=flat-square)](https://rubygems.org/gems/google_visualr)
[![Build Status](http://img.shields.io/travis/winston/google_visualr.svg?style=flat-square)](https://travis-ci.org/winston/google_visualr)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](https://github.com/winston/google_visualr/blob/master/MIT-LICENSE)

GoogleVisualr, is a wrapper around the [Google Charts](https://developers.google.com/chart/) that allows anyone to create beautiful charts with just plain Ruby. You don't have to write any JavaScript at all.

It's good for any Ruby (Rails/Sinatra) setup, and you can handle the entire charting logic in Ruby.

Please refer to the [GoogleVisualr API Reference site](http://googlevisualr.heroku.com/) for a complete list of Google charts that you can create with GoogleVisualr.

## tl:dr

* In your model or controller, write Ruby code to create your chart (e.g. Area Chart, Bar Chart etc).
* Configure your chart with any of the options as listed in Google's API Docs. E.g. [Area Chart](http://code.google.com/apis/chart/interactive/docs/gallery/areachart.html#Configuration_Options).
* In your view, call `chart.to_js(div_id)` and that renders JavaScript into the HTML output.
* You get your awesome Google chart, and you didn't write any JavaScript!

## Limitations

GoogleVisualr is not a 100% complete wrapper for Google Chart Tools.

`Methods` and `Events` as described in Google's API Docs - for use after a chart has been rendered, 
are not implemented because they feel more natural being written as JavaScript functions, within the views or .js files.

## Install

Assuming you are on Rails 3/4, include the gem in your Gemfile.

    gem "google_visualr", ">= 2.5"

## Basics

This is a basic implementation of `GoogleVisualr::DataTable` and `GoogleVisualr::AreaChart`.

For detailed documentation, please refer to the [GoogleVisualr API Reference](http://googlevisualr.heroku.com/) or [read the source](https://github.com/winston/google_visualr_app).

---

In your Rails layout, load Google Ajax API in the head tag, at the very top.

    <script src='https://www.google.com/jsapi'></script>

In your Rails controller, initialize a GoogleVisualr::DataTable object with an empty constructor.

    data_table = GoogleVisualr::DataTable.new

Populate data_table with column headers, and row values.

	# Add Column Headers
	data_table.new_column('string', 'Year' )
	data_table.new_column('number', 'Sales')
	data_table.new_column('number', 'Expenses')

	# Add Rows and Values
	data_table.add_rows([
		['2004', 1000, 400],
		['2005', 1170, 460],
		['2006', 660, 1120],
		['2007', 1030, 540]
	])

Create a GoogleVisualr::AreaChart with data_table and configuration options.

	option = { width: 400, height: 240, title: 'Company Performance' }
	@chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

In your Rails view, render the Google chart.

	<div id='chart'></div>
	<%= render_chart(@chart, 'chart') %>

## Chart Initializer

The initializer of `GoogleVisualr::<ChartName>` takes in two parameters: `data_table` and `options`.

### `data_table` 

`data_table` is an instance of `GoogleVisualr::DataTable` and contains headers and rows of data.

### `options`

`options` is a hash of configuration options for the Google chart (e.g. width, height, colors etc). 

The available configuration options are exactly the same as those specified in Google's API Docs.

For example: 
- [Configuration options for AreaChart](https://developers.google.com/chart/interactive/docs/gallery/areachart#configuration-options)
- [Configuration options for BarChart](https://developers.google.com/chart/interactive/docs/gallery/barchart#configuration-options)
 
At the same time, you can also specify `version`, `language` and `material` as configuration options.

#### `version`

The default version of Google Charts library loaded is `1.0`. 

However, some charts (e.g. Gantt Charts) require the latest version of the Google Charts library,
so you will have to specify `version` as `1.1` in the configuration options 

```
....
@chart = GoogleVisualr::GanttChart.new(data_table, { version: '1.1' })
```

[Read more about it on Google's API Docs](https://developers.google.com/chart/interactive/docs/basic_load_libs).

#### `language` 

The default locale of all Google Charts is `en`.
 
You can override this default by specifying `language` in the configuration options.

```
....
@chart = GoogleVisualr::BarChart.new(data_table, { language: 'ja' })
```

[Read more about it on Google's API Docs](https://developers.google.com/chart/interactive/docs/library_loading_enhancements#loadwithlocale).

#### `material`

Google has also enabled `Material` design for some charts:

> In 2014, Google announced guidelines intended to support a common look and feel across its properties and apps (such as Android apps) that run on Google platforms. We call this effort Material Design. We'll be providing "Material" versions of all our core charts; you're welcome to use them if you like how they look.

To use material design, you will have to specify `material` as `true` 
in the configuration options.

```
....
@chart = GoogleVisualr::BarChart.new(data_table, { material: true })
```

## Listeners

For an example usage of `listeners`, please refer to [this comment](https://github.com/winston/google_visualr/issues/36#issuecomment-9880256).

Besides `listeners` you can now also redraw charts in your JavaScript maunally by calling `draw_<element id>()` function. See [this commit](https://github.com/winston/google_visualr/commit/e5554886bd83f56dd31bbc543fdcf1e24523776a) for more details.

## Support

Please submit all feedback, bugs and feature-requests to [GitHub Issues Tracker](http://github.com/winston/google_visualr/issues).

Feel free to fork the project, make improvements or bug fixes and submit pull requests (with tests!).

## Who's Using GoogleVisualr?

I would like to collect some data about who's using this Gem. [Please drop me a line](mailto:winstonyw+googlevisualr@gmail.com).

## Author

GoogleVisualr is maintained by [Winston Teo](mailto:winstonyw+googlevisualr@gmail.com).

Who is Winston Teo? [You should follow Winston on Twitter](http://www.twitter.com/winstonyw), or find out more on [WinstonYW](http://www.winstonyw.com).

## License

Copyright © 2015 Winston Teo Yong Wei. Free software, released under the MIT license.
