part of 'widgets.dart';

class PreferedAppbar extends StatelessWidget with PreferredSizeWidget {
  final String title, subtitle;

  const PreferedAppbar({Key key, @required this.title, @required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
          bottom: false,
          child: ListView(
            children: [
              // Appbar title
              const SizedBox(
                height: edge,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: Text(
                  title,
                  style: blackTextStyle.copyWith(fontSize: 24.0),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: Text(
                  subtitle,
                  style: grayTextStyle.copyWith(fontSize: 14.0),
                ),
              ),
            ],
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110.0);
}
