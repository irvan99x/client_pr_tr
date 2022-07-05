part of 'widgets.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const RoundedButton(
      {Key key,
      @required this.onPressed,
      @required this.child,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(50)),
          shadowColor:
              MaterialStateProperty.all<Color>(grayColor.withAlpha(200)),
          elevation: MaterialStateProperty.all<double>(10.0),
          backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? purpleColor.withAlpha(200)),
          foregroundColor: MaterialStateProperty.all(whiteColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
    );
  }
}
