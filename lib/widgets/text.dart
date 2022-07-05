part of 'widgets.dart';

class HeadlineText extends StatelessWidget {
  final String headline;

  const HeadlineText({Key key, @required this.headline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: edge),
      child: Text(
        headline,
        style: blackTextStyle.copyWith(fontSize: 24.0),
      ),
    );
  }
}
