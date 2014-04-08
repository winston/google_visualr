# GoogleVisualr

[<img src="https://secure.travis-ci.org/winston/google_visualr.png?branch=master" alt="Build Status" />](http://travis-ci.org/winston/google_visualr)

GoogleVisualr, is a wrapper around the [Google Chart Tools](http://code.google.com/apis/chart/interactive/docs/index.html) that allows anyone to create beautiful charts with just plain Ruby. You don't have to write any JavaScript at all.

It's good for any Ruby (Rails/Sinatra) setup, and you can handle the entire charting logic in Ruby.

Please refer to the [GoogleVisualr API Reference site](http://googlevisualr.heroku.com/) for a complete list of Google charts that you can create with GoogleVisualr.

## tl:dr

* In your model or controller, write Ruby code to create your chart (e.g. Area Chart, Bar Chart etc).
* Configure your chart with any of the options as listed in Google's API Docs. E.g. [Area Chart](http://code.google.com/apis/chart/interactive/docs/gallery/areachart.html#Configuration_Options).
* In your view, call `chart.to_js(div_id)` and that will insert JavaScript into the final HTML output.
* You get your awesome Google chart, and you didn't write any JavaScript!

## Limitations

GoogleVisualr is created solely for the aim of simplifying the display of a chart, and not the interactions.

Hence, do note that GoogleVisualr is not a 100% complete wrapper for Google Chart Tools.

E.g., Methods and Events as described in Google's API Docs - for use after a chart has been rendered, are not implemented because they feel more natural being written as JavaScript functions, within the views or .js files.

## Install

Assuming you are on Rails 3, include the gem in your Gemfile.

    gem "google_visualr", ">= 2.1"

## Basics

This is a basic implementation of the GoogleVisualr::DataTable and GoogleVisualr::AreaChart classes.

For detailed documentation and advanced implementations, please refer to the [GoogleVisualr API Reference](http://googlevisualr.heroku.com/) or read the source.

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

## Listeners

For an example usage of `listeners`, please refer to [this comment](https://github.com/winston/google_visualr/issues/36#issuecomment-9880256).

Besides `listeners` you can now also redraw charts in your JavaScript maunally by calling `draw_<element id>()` function. See [this commit](https://github.com/winston/google_visualr/commit/e5554886bd83f56dd31bbc543fdcf1e24523776a) for more details.

## Support

Please submit all feedback, bugs and feature-requests to [GitHub Issues Tracker](http://github.com/winston/google_visualr/issues).

Feel free to fork the project, make improvements or bug fixes and submit pull requests (with tests!).

## Who's Using GoogleVisualr?

I would like to collect some data about who's using this Gem. [Please drop me a line](mailto:winstonyw+googlevisualr@gmail.com).

## Change Log

<em>Version 2.3.0</em>

* [Issue 69](https://github.com/winston/google_visualr/pull/69) Support generating chart Javascript without <script> tag
* Split `base_chart#to_js` into 3 methods - `to_js`, `load_js` and `draw_js` which can be used on their own.

<em>Version 2.2.0</em>

* [Issue 64](https://github.com/winston/google_visualr/pull/64) Works with Turbolinks.
* [Issue 65](https://github.com/winston/google_visualr/pull/65) Add InteractiveTimeline chart.

<em>Version 2.1.9</em>

* [Issue 61](https://github.com/winston/google_visualr/issues/45) Add MIT license to gemspec.

<em>Version 2.1.8</em>

* [Issue 45](https://github.com/winston/google_visualr/issues/45) Support for redrawing chart from JS.

<em>Version 2.1.7</em>

* [Issue 56](https://github.com/winston/google_visualr/issues/56) Typecast to proper JSON strings.

<em>Version 2.1.6</em>

* [Issue 54](https://github.com/winston/google_visualr/issues/54) Allow apostrophes in labels.
* [Pull Request 55](https://github.com/winston/google_visualr/pull/55) Added support to accept BigDecimal as number.

<em>Version 2.1.5</em>

* [Pull Request 48](https://github.com/winston/google_visualr/pull/48) Fixed bug with Listener event registration.

<em>Version 2.1.4</em>

* [Pull Request 39](https://github.com/winston/google_visualr/pull/39) Added ability to use Listeners.
* [Pull Request 40](https://github.com/winston/google_visualr/pull/40) Allowed decoupling of class name and chart name.

<em>Version 2.1.3</em>

* Added support for Bubble Chart.
* [Pull Request 37](https://github.com/winston/google_visualr/pull/37) Added support for Stepped Area Chart.

<em>Version 2.1.2</em>

* [Pull Request 28](https://github.com/winston/google_visualr/pull/28) Removed InstanceMethods as it's deprecated in Rails 3.2.x.
* [Pull Request 26](https://github.com/winston/google_visualr/pull/26) Added 3 more image charts and #uri method to all image charts.

<em>Version 2.1.1</em>

* Added support for `role` and `pattern` attributes in `#new_column` and `#new_columns` methods.

<em>Version 2.1.0</em>

* Added `#render_chart` as a helper method in Rails views.

## Author

GoogleVisualr is maintained by [Winston Teo](mailto:winstonyw+googlevisualr@gmail.com).

Who is Winston Teo? [You should follow Winston on Twitter](http://www.twitter.com/winstonyw), or find out more on [WinstonYW](http://www.winstonyw.com) and [LinkedIn](http://sg.linkedin.com/in/winstonyw).

## License

Copyright © 2012 Winston Teo Yong Wei. Free software, released under the MIT license.
