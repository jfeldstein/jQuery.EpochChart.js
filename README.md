jQuery.EpochChart.js
====================

Plot important chronological events on top of your trending data to learn what decisions and macro events affected your numbers. 

Built by [@jfeldstein](http://twitter.com/jfeldstein) and is powered by (and requires) HighCharts. Originally announced at http://jfeldstein.com/...

This code is free. Go nuts. 

## Get it: 

1. Have jQuery and Highcharts already installed in your project.
2. Download [jquery.epochchart.js](https://raw.github.com/jfeldstein/jQuery.EpochChart.js/master/jquery.epochchart.js) into your project.
3. Have fun!

## It's used like so: 
  
    // One line
    $('#chart').epochchart(line,  markers [, options]);

    or 

    // Multiple lines
    $('#chart').epochchart(lines, markers [, options]);

### It supports these options: 

    {
      // Change the marker used to denote events, or link to a custom image.
      marker: url(marker.png), 

      // Overwrite the options we pass into Highcharts here. 
      // Use anything from http://api.highcharts.com/highcharts
      highchartsOpts: { ... }
    }


## Real Examples: 

### 1. Graph one line, with markers:

    <div id="oneline"></div>

    <script>
      // Dates as unix timestamps
      var line    = {
        name: "The Line",
        data: [[1259114255000, 2], [1259200655000, 2.25], [1259287055000, 5]]
      };

      var markers = [[1259200655000, "Hired the new sales guy."]];

      $('#oneline').epochchart(line, markers);
    </script>

Which looks like: 

![An EpochChart with one line](https://raw.github.com/jfeldstein/jQuery.EpochChart.js/master/examples/images/basic.png "An EpochChart with one line")



### 2. Or to graph multiple lines: 

    <div id="chart"></div>

    <script>
      // Dates as unix timestamps
      var data1   = [[1259114255000, 2], [1259287055000, 5]];
      var data2   = [[1259114255000, 5], [1259287055000, 2]];
      
      var lines   = [{
        name: "Line 1",
        data: data1
      },{
        name: "Line 2",
        data: data2
      }]
      
      var markers = [[1259200655000, "The intersection"]];

      $('#chart').epochchart(lines, markers);
    </script>

Which looks like:

![An EpochChart with TWO lines](https://raw.github.com/jfeldstein/jQuery.EpochChart.js/master/examples/images/twolines.png "An EpochChart with TWO lines")



### 3. Or pass overrides to the underlying Highcharts implementation:

    <div id="chart"></div>

    <script>
      // Anything from the HighCharts API: http://api.highcharts.com/highcharts
      var opts = {
        highchartsOpts: {
          plotOptions: {
              spline: {
                  color: '#FF0000'
              }
          }
        }
      };

      var line = {
        name: "A Single Line",
        data: [[1259114255000, 2], [1259287055000, 5]]
      };
      var markers = [[1259200655000, "On the up!"]];

      $('#chart').epochchart(lines, markers, opts);
    </script>

Which looks like: 

![An EpochChart with custom Highcharts options](https://raw.github.com/jfeldstein/jQuery.EpochChart.js/master/examples/images/customcolor.png "An EpochChart with custom Highcharts options")



## Compile With

`coffee --compile --watch --bare jquery.epochchart.coffee`

