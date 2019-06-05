const _baseUrl = "sharebuddy-api.herokuapp.com";
const _appId = "ca-app-pub-3940256099942544~3347511713";

const _banner = "ca-app-pub-3940256099942544/6300978111";
const _largeBanner = "ca-app-pub-3940256099942544/6300978111";
const _mediumBanner = "ca-app-pub-3940256099942544/6300978111";
const _fullBanner = "ca-app-pub-3940256099942544/6300978111";
const _leaderboardBanner = "ca-app-pub-3940256099942544/6300978111";

/* Api Enum */
enum endpoint {
  getAllLocation,
  getLocationFromTo,
  getLocationList,
  getLocationFromCurrent,
  register,
  getToken,
  addFeedback,
}

/* Admob Enum */
enum bannerAdType {
  BANNER, // 320x50
  LARGE_BANNER, // 320x100
  MEDIUM_RECTANGLE, // 300x250
  FULL_BANNER, // 468x60
  LEADERBOARD, // 728x90
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

/* List of Banner Ads - Admob */
Map<bannerAdType, String> _bannerAdType = {
  bannerAdType.BANNER: _banner,
  bannerAdType.LARGE_BANNER: _largeBanner,
  bannerAdType.MEDIUM_RECTANGLE: _mediumBanner,
  bannerAdType.FULL_BANNER: _fullBanner,
  bannerAdType.LEADERBOARD: _leaderboardBanner,
};
  

/* Api */
String getApiEndpoint(endpoint) => _apiEndpoint[endpoint];
String getBaseurl() => _baseUrl;

/*Admob */
String getAppId() => _appId;
String getBannerAdUnitId(bannerAdType) => _bannerAdType[bannerAdType];
