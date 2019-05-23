const _baseUrl = "sharebuddy-api.herokuapp.com";

enum endpoint {
  getAllLocation,
  getLocationFromTo,
  getLocationList,
  getLocationFromCurrent,
  register,
  getToken,
  addFeedback,
}

/* List of Api Endpoint */
Map<endpoint, String> _apiEndpoint = {
  endpoint.getAllLocation: "/location/getAllLocation",
  endpoint.getLocationFromTo: "/location/getLocationFromTo",
  endpoint.getLocationList: "/location/getLocationList",
  endpoint.getLocationFromCurrent: "/location/getLocationFromCurrent",
  endpoint.register: "/user/register",
  endpoint.getToken: "/user/getToken",
  endpoint.addFeedback: "/user/addFeedback"
};

String getApiEndpoint(endpoint) => _apiEndpoint[endpoint];

String getBaseurl() => _baseUrl;
