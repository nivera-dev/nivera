import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niveraapp/constants.dart';

class SettingTile extends StatefulWidget {
  final String title;
  final dynamic route;
  final IconData icon;

  const SettingTile(
      {Key? key, required this.title, required this.route, required this.icon})
      : super(key: key);

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: () {
          _handleTilePressed(context);
        },
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    )
                )
        ),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              margin: const EdgeInsets.only(bottom: 5.0, top: 5.0),
              decoration: BoxDecoration(
                color: ColorPalette.whiteFloor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                widget.icon,
                color: ColorPalette.subColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.title,
              style: mRobotoBold.copyWith(
                  color: ColorPalette.subColor,
                  fontSize: 14
              ),
            ),
            const Spacer(),
            const Icon(CupertinoIcons.chevron_forward, color: ColorPalette.subColor,),
          ],
        ),
      ),
    );
  }

  void _handleTilePressed(BuildContext context) {
    if(widget.route is String) {
      Navigator.pushReplacement(context, widget.route);
    } else if (widget.route is Function){
      final Function action = widget.route;
      action();
    }
  }

}