part of 'widgets.dart';

class AvatarContainer extends StatelessWidget {
  final String imageUrl, name;

  const AvatarContainer({Key key, @required this.imageUrl, @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, style: whiteTextStyle.copyWith(fontSize: 20)),
            ],
          )
        ],
      ),
    );
  }
}
