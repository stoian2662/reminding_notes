import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminding_notes/core/notes/dto/note_data.dart';

import 'models/note_view_model.dart';

class NoteListItemWidget extends StatelessWidget {
  final NoteViewModel model;

  const NoteListItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dismissible(
            key: ValueKey(model.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.delete_rounded, size: 50.0),
            ),
            onDismissed: (_) {},
            child: ListTile(
              enabled: model.status != NoteStatus.done,
              shape: Border(
                bottom: BorderSide(color: Theme.of(context).splashColor),
              ),
              title: Text(model.title!),
              isThreeLine: false,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.description!),
                ],
              ),
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.status == NoteStatus.done)
                    const Icon(Icons.done_rounded, size: 32)
                  else if (model.type == NoteType.scheduled)
                    const Icon(Icons.alarm_on_rounded, size: 32)
                  else if (model.type == NoteType.daily ||
                      model.type == NoteType.weekly ||
                      model.type == NoteType.monthly ||
                      model.type == NoteType.annual)
                    const Icon(Icons.repeat_rounded, size: 32),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(DateFormat.Hm().format(model.dateTime!)),
                  if (model.type == NoteType.daily) const Text('daily'),
                  if (model.type == NoteType.weekly)
                    Text('each ${DateFormat.EEEE().format(model.dateTime!)}'),
                  if (model.type == NoteType.monthly) const Text('monthly'),
                  if (model.type == NoteType.annual) const Text('annual'),
                ],
              ),
              onTap: () => Navigator.of(context).pushNamed('/editItem'),
            ),
          ),
        ],
      );
}
