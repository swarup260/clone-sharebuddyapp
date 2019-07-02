class PageModel {
  final String assetImagePath;
  final String text;
  PageModel({this.assetImagePath, this.text});
}

List<PageModel> pages = [
  PageModel(
    assetImagePath: 'assets/images/walkthrough_1.png',
    text: '1Want to take up a strength or weight lifting program ',
  ),
  PageModel(
    assetImagePath: 'assets/images/walkthrough_2.png',
    text: 'Crank up the intensity and revitalize your training',
  ),
  PageModel(
      assetImagePath: 'assets/images/walkthrough_3.png',
      text: 'Track your progress and get Testing'),
  PageModel(
      assetImagePath: 'assets/images/walkthrough_4.png',
      text: 'Get your Location from .'),
];
