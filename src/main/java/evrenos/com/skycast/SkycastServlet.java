package evrenos.com.skycast;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.dvdme.ForecastIOLib.FIODaily;
import com.github.dvdme.ForecastIOLib.ForecastIO;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.model.GeocodingResult;

public class SkycastServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public SkycastServlet() {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ArrayIndexOutOfBoundsException {

		// ******** Google Geocoding ***********
		GeoApiContext context = new GeoApiContext().setApiKey("xxxxxxxxx");
		GeocodingResult[] results = null;
		String location = null;
		location = request.getParameter("location");

		try {
			results = GeocodingApi.geocode(context, location).await();
		} catch (Exception e) {
			e.printStackTrace();
		}

		String latitude = null;
		String longitude = null;

		try {
			latitude = String.valueOf(results[0].geometry.location.lat);
			longitude = String.valueOf(results[0].geometry.location.lng);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// ******** Forecast.io ***********
		ForecastIO fio = new ForecastIO("xxxxxxxxxxx");
		fio.setUnits(ForecastIO.UNITS_US);
		fio.setLang(ForecastIO.LANG_ENGLISH);
		fio.getForecast(latitude, longitude);
		fio.setTime("5");

		FIODaily daily = new FIODaily(fio);

		Gson gson = new Gson();
		JsonObject obj = new JsonObject();
		Map<String, String> map = new HashMap<String, String>();

		for (int i = 0; i < daily.days(); i++) {
			String[] h = daily.getDay(i).getFieldsArray();

			for (int j = 0; j < h.length; j++) {
				map.put(h[j], daily.getDay(i).getByKey(h[j]));
				obj.add("Day" + (i + 1), gson.toJsonTree(gson.toJson(map)));
			}
		}

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(gson.toJson(obj));
	}
}