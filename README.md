jQuery.EpochChart.js
====================

HighCharts mashup for plotting important chronological events on top of your trending data

Built by [@jfeldstein](http://twitter.com/jfeldstein), originally announced at http://jfeldstein.com/...

This code is free. Go nuts. 

## Use it like so: 

### 1. Graph one line, with markers:

    <div id="chart"></div>

    <script>
      // Dates as unix timestamps
      var day1 = Date.parse("24-Nov-2009 17:57:35").getTime()/1000;
      var day2 = Date.parse("25-Nov-2009 17:57:35").getTime()/1000;
      var day3 = Date.parse("26-Nov-2009 17:57:35").getTime()/1000;

      var line    = [[day1, 2], [day3, 5]];
      var markers = [[day2, "Things are getting better."]];

      $('#chart').epochchart(line, markers);
    </script>

Which looks like: 

....


### 2. Or to graph multiple lines: 

    <div id="chart"></div>

    <script>
      // Dates as unix timestamps
      var day1 = Date.parse("24-Nov-2009 17:57:35").getTime()/1000;
      var day2 = Date.parse("25-Nov-2009 17:57:35").getTime()/1000;
      var day3 = Date.parse("26-Nov-2009 17:57:35").getTime()/1000;

      var lines   = [];
      var line1   = [[day1, 2], [day3, 5]];
      var line2   = [[day1, 5], [day3, 2]];
      
      var markers = [[day2, "The intersection"]];

      $('#chart').epochchart(lines, markers);
    </script>

Which looks like:

....


## Compile With

`coffee --compile --watch --bare jquery.epochchart.coffee`
>>>>>>> Initial commit with lots of love
