enum Role { hu, ai }

class Message {
  final Role owner;
  final StringBuffer messageBuffer;

  Message({
    required this.owner,
    required this.messageBuffer,
  });
}
