<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1">

<title>SkyCast</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/app.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<link href="http://fonts.googleapis.com/css?family=Roboto:300,400,700|" rel="stylesheet" type="text/css">
<link href="fonts/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet">

<script>
$(document).ready(function() {
	  $('#submitButton').click(function(event) {
	    var locationInfo = $('#location').val();
	    //alert(locationInfo);

	    if (locationInfo == null || locationInfo == "") {
	      alert("Please enter a location");
	      return;
	    } else {
	      var d = new Date();
	      var weekday = new Array(7);
	      weekday[0] = "Sunday";
	      weekday[1] = "Monday";
	      weekday[2] = "Tuesday";
	      weekday[3] = "Wednesday";
	      weekday[4] = "Thursday";
	      weekday[5] = "Friday";
	      weekday[6] = "Saturday";

	      var day = weekday[d.getDay()];

	      for (var i = 0; i < weekday.length; i++) {
	        $("#day1").text(weekday[d.getDay()]);

	        if (weekday[d.getDay()] == "Saturday") {
	          $("#day2").text(weekday[d.getDay() - 6]);
	          $("#day3").text(weekday[d.getDay() - 5]);
	          $("#day4").text(weekday[d.getDay() - 4]);
	          $("#day5").text(weekday[d.getDay() - 3]);
	          $("#day6").text(weekday[d.getDay() - 2]);
	          $("#day7").text(weekday[d.getDay() - 1]);

	        } else if (weekday[d.getDay()] == "Sunday") {
	          $("#day2").text(weekday[d.getDay() + 1]);
	          $("#day3").text(weekday[d.getDay() + 2]);
	          $("#day4").text(weekday[d.getDay() + 3]);
	          $("#day5").text(weekday[d.getDay() + 4]);
	          $("#day6").text(weekday[d.getDay() + 5]);
	          $("#day7").text(weekday[d.getDay() + 6]);

	        } else if (weekday[d.getDay()] == "Monday") {
	          $("#day2").text(weekday[d.getDay() + 1]);
	          $("#day3").text(weekday[d.getDay() + 2]);
	          $("#day4").text(weekday[d.getDay() + 3]);
	          $("#day5").text(weekday[d.getDay() + 4]);
	          $("#day6").text(weekday[d.getDay() + 5]);
	          $("#day7").text(weekday[d.getDay() - 1]);
	        } else if (weekday[d.getDay()] == "Tuesday") {
	          $("#day2").text(weekday[d.getDay() + 1]);
	          $("#day3").text(weekday[d.getDay() + 2]);
	          $("#day4").text(weekday[d.getDay() + 3]);
	          $("#day5").text(weekday[d.getDay() + 4]);
	          $("#day6").text(weekday[d.getDay() - 2]);
	          $("#day7").text(weekday[d.getDay() - 1]);

	        } else if (weekday[d.getDay()] == "Wednesday") {
	          $("#day2").text(weekday[d.getDay() + 1]);
	          $("#day3").text(weekday[d.getDay() + 2]);
	          $("#day4").text(weekday[d.getDay() + 3]);
	          $("#day5").text(weekday[d.getDay() - 3]);
	          $("#day6").text(weekday[d.getDay() - 2]);
	          $("#day7").text(weekday[d.getDay() - 1]);

	        } else if (weekday[d.getDay()] == "Thursday") {
	          $("#day2").text(weekday[d.getDay() + 1]);
	          $("#day3").text(weekday[d.getDay() + 2]);
	          $("#day4").text(weekday[d.getDay() - 4]);
	          $("#day5").text(weekday[d.getDay() - 3]);
	          $("#day6").text(weekday[d.getDay() - 2]);
	          $("#day7").text(weekday[d.getDay() - 1]);

	        } else if (weekday[d.getDay()] == "Friday") {
	          $("#day2").text(weekday[d.getDay() + 1]);
	          $("#day3").text(weekday[d.getDay() - 5]);
	          $("#day4").text(weekday[d.getDay() - 4]);
	          $("#day5").text(weekday[d.getDay() - 3]);
	          $("#day6").text(weekday[d.getDay() - 2]);
	          $("#day7").text(weekday[d.getDay() - 1]);
	        }
	      }

	      $("#address").text(locationInfo);
	      var id = 1;
	      $.get('SkycastServlet', {
	        location: locationInfo
	      }, function(data) {
	        $.each(data, function(key, val) {

	          obj = $.parseJSON(data[key]);
	          $("#temperature" + id).text(Math.round(obj['temperatureMax']));
	          $("#mintemperature" + id).text(Math.round(obj['temperatureMin']));
	          $("#precip" + id).text(Math.round(obj['precipProbability'] * 100) + "%");
	          $("#humidity" + id).text(Math.round(obj['humidity'] * 100) + "%");
	          $("#umbrella").show();
	          $("#wind").show();
	          $("#summary" + id).text(obj['summary'].replace(/"/g, "").replace(/\.$/, ""));
	          $("#windspeed" + id).text(obj['windSpeed'] + " mi/h");

	          if (obj['icon'].replace(/"/g, "") == "clear-day") {
	            $("#icon" + id).attr("src", "images/icons/icon-2.svg");
	          } else if (obj['icon'].replace(/"/g, "") == "partly-cloudy-day") {
	            $("#icon" + id).attr("src", "images/icons/icon-3.svg");

	          } else if (obj['icon'].replace(/"/g, "") == "cloudy") {
	            $("#icon" + id).attr("src", "images/icons/icon-5.svg");

	          } else if (obj['icon'].replace(/"/g, "") == "fog") {
	            $("#icon" + id).attr("src", "images/icons/icon-7.svg");

	          } else if (obj['icon'].replace(/"/g, "") == "rain") {
	            $("#icon" + id).attr("src", "images/icons/icon-10.svg");

	          } else if (obj['icon'].replace(/"/g, "") == "sleet") {
	            $("#icon" + id).attr("src", "images/icons/icon-13.svg");

	          } else if (obj['icon'].replace(/"/g, "") == "snow") {
	            $("#icon" + id).attr("src", "images/icons/icon-14.svg");

	          } else if (obj['icon'].replace(/"/g, "") == "clear-night" || obj['icon'].replace(/"/g, "") == "wind" || obj['icon'].replace(/"/g, "") == "partly-cloudy-night") {
	            $("#icon" + id).attr("src", "images/icons/icon-6.svg");
	          }

	          //Chart populated with bogus data - prototype only

	          $('#container').highcharts({
	            chart: {
	              zoomType: 'xy'
	            },
	            title: {
	              text: 'Average Monthly Weather Data'
	            },
	            subtitle: {
	              text: 'Prototype only - Not real data'
	            },
	            xAxis: [{
	              categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
	                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
	              ],
	              crosshair: true
	            }],
	            yAxis: [{ // Primary yAxis
	              labels: {
	                format: '{value}°F',
	                style: {
	                  color: Highcharts.getOptions().colors[2]
	                }
	              },
	              title: {
	                text: 'Temperature',
	                style: {
	                  color: Highcharts.getOptions().colors[2]
	                }
	              },
	              opposite: true

	            }, { // Secondary yAxis
	              gridLineWidth: 0,
	              title: {
	                text: 'Rainfall',
	                style: {
	                  color: Highcharts.getOptions().colors[0]
	                }
	              },
	              labels: {
	                format: '{value} mm',
	                style: {
	                  color: Highcharts.getOptions().colors[0]
	                }
	              }

	            }, { // Tertiary yAxis
	              gridLineWidth: 0,
	              title: {
	                text: 'Humidity',
	                style: {
	                  color: Highcharts.getOptions().colors[1]
	                }
	              },
	              labels: {
	                format: '{value} %',
	                style: {
	                  color: Highcharts.getOptions().colors[1]
	                }
	              },
	              opposite: true
	            }],
	            tooltip: {
	              shared: true
	            },
	            legend: {
	              layout: 'vertical',
	              align: 'left',
	              x: 80,
	              verticalAlign: 'top',
	              y: 55,
	              floating: true,
	              backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
	            },
	            series: [{
	              name: 'Rainfall',
	              type: 'column',
	              yAxis: 1,
	              data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
	              tooltip: {
	                valueSuffix: ' mm'
	              }
	            }, {
	              name: 'Humidity',
	              type: 'spline',
	              yAxis: 2,
	              data: [2, 4, 23, 33, 17, 45, 68, 78, 53, 23, 12, 6],
	              marker: {
	                enabled: false
	              },
	              dashStyle: 'shortdot',
	              tooltip: {
	                valueSuffix: '%'
	              }
	            }, {
	              name: 'Temperature',
	              type: 'spline',
	              data: [-16, -22, -10, 40, 55, 75, 82, 69, 52, 49, 38, 34],
	              tooltip: {
	                valueSuffix: ' °F'
	              }
	            }]
	          });
	          id++;
	        });
	      });
	    }
	  });
	});
	
</script>

<!--[if lt IE 9]>
        <script src="js/ie-support/html5.js"></script>
        <script src="js/ie-support/respond.js"></script>
        <![endif]-->
</head>

<body>
  <div class="site-content">
    <div class="site-header">
      <div class="container">
        <a href="index.jsp" class="branding"> <img src="images/logo.png" alt="" class="logo">
          <div class="logo-type">
            <h1 class="site-title">SkyCast</h1>
            <small class="site-description">What's it like today?</small>
          </div>
        </a>
        <!-- Default snippet for navigation -->
        <div class="main-navigation">
          <button type="button" class="menu-toggle">
            <i class="fa fa-bars"></i>
          </button>
        </div>
        <!-- .main-navigation -->
        <div class="mobile-navigation"></div>
      </div>
    </div>
    <!-- .site-header -->

    <div class="hero" data-bg-image="images/banner.png">
      <div class="container">
        <form class="find-location" onsubmit="return false">
          <input type="text" id="location" style="background: black;" placeholder="Find your location..">
          <input type="submit" id="submitButton" value="Find">
        </form>
      </div>
    </div>
    <div class="forecast-table">
      <div class="container">
        <div class="forecast-container">
          <div class="today forecast">
            <div class="forecast-header">
              <div class="day" id="day1"></div>
            </div>
            <!-- .forecast-header -->
            <div class="forecast-content">
              <div class="location" id="address"></div>
              <div class="degree">
                <div class="num">
                  <span id="temperature1"></span><sup>o</sup>F
                </div>
                <div class="forecast-icon">
                  <img id="icon1" alt="" width=90>
                </div>
              </div>
              <span id="umbrella" style="display:none"><img src="images/icon-umberella.png" alt=""><span id="precip1"></span></span>
              <span id="wind" style="display:none"><img src="images/icon-wind.png" alt=""><span id="windspeed1"></span></span>
              <br/>
              <br/>
              <div class="day" id="summary1"></div>
            </div>
          </div>
          <div class="forecast">
            <div class="forecast-header">
              <div class="day" id="day2"></div>
            </div>
            <!-- .forecast-header -->
            <div class="forecast-content">
              <div class="forecast-icon">
                <img id="icon2" alt="" width=48>
              </div>
              <div class="degree">
                <span id="temperature2"></span> <sup>o</sup>F
              </div>
              <small id="mintemperature2"></small><sup>o</sup>F
            </div>
          </div>
          <div class="forecast">
            <div class="forecast-header">
              <div class="day" id="day3"></div>
            </div>
            <!-- .forecast-header -->
            <div class="forecast-content">
              <div class="forecast-icon">
                <img id="icon3" alt="" width=48>
              </div>
              <div class="degree">
                <span id="temperature3"></span> <sup>o</sup>F
              </div>
              <small id="mintemperature3"></small><sup>o</sup>F
            </div>
          </div>
          <div class="forecast">
            <div class="forecast-header">
              <div class="day" id="day4"></div>
            </div>
            <!-- .forecast-header -->
            <div class="forecast-content">
              <div class="forecast-icon">
                <img id="icon4" alt="" width=48>
              </div>
              <div class="degree">
                <span id="temperature4"></span> <sup>o</sup>F
              </div>
              <small id="mintemperature4"></small><sup>o</sup>F
            </div>
          </div>
          <div class="forecast">
            <div class="forecast-header">
              <div class="day5" id="day5"></div>
            </div>
            <!-- .forecast-header -->
            <div class="forecast-content">
              <div class="forecast-icon">
                <img id="icon5" alt="" width=48>
              </div>
              <div class="degree">
                <span id="temperature5"></span> <sup>o</sup>F
              </div>
              <small id="mintemperature5"></small><sup>o</sup>F
            </div>
          </div>
          <div class="forecast">
            <div class="forecast-header">
              <div class="day" id="day6"></div>
            </div>
            <!-- .forecast-header -->
            <div class="forecast-content">
              <div class="forecast-icon">
                <img id="icon6" alt="" width=48>
              </div>
              <div class="degree">
                <span id="temperature6"></span> <sup>o</sup>F
              </div>
              <small id="mintemperature6"></small><sup>o</sup>F
            </div>
          </div>
          <div class="forecast">
            <div class="forecast-header">
              <div class="day" id="day7"></div>
            </div>
            <!-- .forecast-header -->
            <div class="forecast-content">
              <div class="forecast-icon">
                <img id="icon7" alt="" width=48>
              </div>
              <div class="degree">
                <span id="temperature7"></span> <sup>o</sup>F
              </div>
              <small id="mintemperature7"></small><sup>o</sup>F
            </div>
          </div>
        </div>
      </div>
    </div>
    <br />
    <br />
    <div class="container">
      <div id="container" style="min-width: 200px; height: 400px"></div>
    </div>

    <footer class="site-footer">
      <div class="container">
        <p class="colophon">Powered by Google Maps Geocoding API, Dark Sky API, Themezy & Highcharts</p>
        <small style="display:none" id="mintemperature1"></small>
      </div>
    </footer>
    <!-- .site-footer -->
  </div>
</body>

</html>