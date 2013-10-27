jQuery.EpochChart.js
====================

HighCharts mashup for plotting important chronological events on top of your trending data

Built by [@jfeldstein](http://twitter.com/jfeldstein), originally announced at http://jfeldstein.com/...

This code is free. Go nuts. 

## Use it like so: 

    $('#chart').epochchart(line,  markers [, highcharts_options]);

    or 

    $('#chart').epochchart(lines, markers [, highcharts_options]);


## Examples: 

### 1. Graph one line, with markers:

    <div id="chart"></div>

    <script>
      // Dates as unix timestamps
      var line    = [[1259114255000, 2], [1259287055000, 5]];
      var markers = [[1259200655000, "Things are getting better."]];

      $('#chart').epochchart(line, markers);
    </script>

Which looks like: 

....


### 2. Or to graph multiple lines: 

    <div id="chart"></div>

    <script>
      // Dates as unix timestamps
      var line1   = [[1259114255000, 2], [1259287055000, 5]];
      var line2   = [[1259114255000, 5], [1259287055000, 2]];
      var lines   = [line1, line2];
      
      var markers = [[1259200655000, "The intersection"]];

      $('#chart').epochchart(lines, markers);
    </script>

Which looks like:

....


### 3. Or pass overrides to the underlying Highcharts implementation:

    <div id="chart"></div>

    <script>
      // Anything from the HighCharts API: http://api.highcharts.com/highcharts
      var opts = {
        plotOptions: {
            spline: {
                color: '#FF0000'
            }
        },
      };

      var line    = [[1259114255000, 2], [1259287055000, 5]];
      var markers = [[1259200655000, "The intersection"]];

      $('#chart').epochchart(lines, markers, opts);
    </script>



## Compile With

`coffee --compile --watch --bare jquery.epochchart.coffee`

