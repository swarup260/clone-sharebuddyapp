class PageModel {
  final String assetImagePath;
  final String text;
  PageModel({this.assetImagePath, this.text});
}

List<PageModel> pages = [
  PageModel(
    assetImagePath: 'assets/images/auto.png',
    text: 'Want to take up a strength or weight lifting program ',
  ),
  PageModel(
    assetImagePath: 'assets/images/auto.png',
    text: 'Crank up the intensity and revitalize your training',
  ),
  PageModel(
      assetImagePath: 'assets/images/taxi.png',
      text: 'Track your progress and get Testing'),
  PageModel(
      assetImagePath: 'assets/images/taxi.png',
      text: 'Get your Location from .'),
];
