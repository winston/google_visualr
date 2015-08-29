## Change Log

### Version 2.5.1

* [Pull Request 98](https://github.com/winston/google_visualr/pull/97) Do not force `en` as the default language.

### Version 2.5.0

* [Pull Request 97](https://github.com/winston/google_visualr/pull/97) Add new Google charts.
* [Pull Request 96](https://github.com/winston/google_visualr/pull/96) Allow charts to have a different locale.
* [Pull Request 95](https://github.com/winston/google_visualr/pull/95) Allow charts to be styled with Material Design.
* [Pull Request 72](https://github.com/winston/google_visualr/pull/72) Add ability to specify version of Google Chart library.

### Version 2.4.0

* [Pull Request 75](https://github.com/winston/google_visualr/pull/75) Add Histogram chart.

### Version 2.3.0

* [Issue 69](https://github.com/winston/google_visualr/pull/69) Support generating chart Javascript without `<script>` tag
* Split `base_chart#to_js` into 3 methods - `to_js`, `load_js` and `draw_js` which can be used on their own.

### Version 2.2.0

* [Issue 64](https://github.com/winston/google_visualr/pull/64) Works with Turbolinks.
* [Issue 65](https://github.com/winston/google_visualr/pull/65) Add InteractiveTimeline chart.

### Version 2.1.9

* [Issue 61](https://github.com/winston/google_visualr/issues/45) Add MIT license to gemspec.

### Version 2.1.8

* [Issue 45](https://github.com/winston/google_visualr/issues/45) Support for redrawing chart from JS.

### Version 2.1.7

* [Issue 56](https://github.com/winston/google_visualr/issues/56) Typecast to proper JSON strings.

### Version 2.1.6

* [Issue 54](https://github.com/winston/google_visualr/issues/54) Allow apostrophes in labels.
* [Pull Request 55](https://github.com/winston/google_visualr/pull/55) Add support to accept BigDecimal as number.

### Version 2.1.5

* [Pull Request 48](https://github.com/winston/google_visualr/pull/48) Fix bug with Listener event registration.

### Version 2.1.4

* [Pull Request 39](https://github.com/winston/google_visualr/pull/39) Add ability to use Listeners.
* [Pull Request 40](https://github.com/winston/google_visualr/pull/40) Allow decoupling of class name and chart name.

### Version 2.1.3

* Added support for Bubble Chart.
* [Pull Request 37](https://github.com/winston/google_visualr/pull/37) Add support for Stepped Area Chart.

### Version 2.1.2

* [Pull Request 28](https://github.com/winston/google_visualr/pull/28) Remove InstanceMethods as it's deprecated in Rails 3.2.x.
* [Pull Request 26](https://github.com/winston/google_visualr/pull/26) Add 3 more image charts and #uri method to all image charts.

### Version 2.1.1

* Add support for `role` and `pattern` attributes in `#new_column` and `#new_columns` methods.

### Version 2.1.0

* Add `#render_chart` as a helper method in Rails views.
