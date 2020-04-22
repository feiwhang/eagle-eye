import 'package:eagle_eye/constants.dart';
import 'package:eagle_eye/layouts/desktop/providers/scroll_provider.dart';
import 'package:eagle_eye/layouts/desktop/routing/locator.dart';
import 'package:eagle_eye/layouts/desktop/routing/navigation_service.dart';
import 'package:eagle_eye/layouts/desktop/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:eagle_eye/layouts/desktop/extensions/hover_extension.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DesktopBar extends StatelessWidget {
  final int pageIndex;
  final ScrollProvider scrollProvider;

  const DesktopBar({Key key, this.pageIndex, this.scrollProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            spreadRadius: 1.99,
            blurRadius: 9.99,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ScrollProgress(progress: scrollProvider.progress),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            height: scrollProvider.barHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: 70,
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _Logo(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(
                      6,
                      (index) => _BarItem(
                            index: index,
                            pageIndex: pageIndex,
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollProgress extends StatelessWidget {
  final double progress;

  const ScrollProgress({Key key, this.progress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8.88,
      padding: EdgeInsets.all(0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width,
        lineHeight: 8.88,
        percent: this.progress,
        backgroundColor: Colors.white,
        linearStrokeCap: LinearStrokeCap.roundAll,
        linearGradient: AppColor.menuGradient,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          locator<NavigationService>().navigateTo(HomeRoute), // pressed home
      child: Image.asset(
        Asset.logo,
        alignment: Alignment.center,
        // height: 100,
        // width: 180,
        fit: BoxFit.cover,
      ).showCursorOnHover,
    );
  }
}

class _BarItem extends StatelessWidget {
  final int index;
  final int pageIndex;

  const _BarItem({Key key, this.index, this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient;
    FontWeight fontWeight = FontWeight.normal;
    Color textColor = Colors.black;

    if (index == pageIndex) {
      gradient = AppColor.menuGradient;
      fontWeight = FontWeight.bold;
      textColor = Colors.white;
    }

    // Navigate when pressed
    String _routeName;
    switch (index) {
      case 0:
        _routeName = HomeRoute;

        break;
      case 1:
        _routeName = AboutRoute;
        break;
      case 2:
        _routeName = ProductRoute;
        break;
      case 3:
        _routeName = SupportRoute;
        break;
      case 4:
        _routeName = EventRoute;
        break;
      case 5:
        _routeName = ContactRoute;
        break;
      default:
    }

    // final MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    return Container(
      width: 140,
      height: 39,
      margin: EdgeInsets.only(left: 2, right: 2),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(32),
      ),
      child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Text(
            Typo.menus[index],
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              letterSpacing: 1,
              fontWeight: fontWeight,
            ),
          ),
          onPressed: () {
            locator<NavigationService>().navigateTo(_routeName);
            // menuProvider.setPageIndex(index);
          }),
    ).showCursorOnHover.moveUpOnHover;
  }
}
