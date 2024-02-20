import 'package:flutter/material.dart';

class FetchingDataError extends StatelessWidget {
  final String message;
  final Function tryAgainCall;

  FetchingDataError({this.message, this.tryAgainCall});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 150),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Error: $message')],
            ),
            MaterialButton(
                onPressed: () {
                  if (tryAgainCall != null) tryAgainCall();
                },
                child: Text('Try again',
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary)))
          ],
        ),
      ),
    );
  }
}
