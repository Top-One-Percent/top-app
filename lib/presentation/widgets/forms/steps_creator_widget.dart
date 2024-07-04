import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:top/presentation/widgets/widgets.dart';

class StepsCreatorWidget extends StatefulWidget {
  final Function(List<String>) onStepsChanged;

  const StepsCreatorWidget({super.key, required this.onStepsChanged});

  @override
  _StepsCreatorWidgetState createState() => _StepsCreatorWidgetState();
}

class _StepsCreatorWidgetState extends State<StepsCreatorWidget> {
  List<String> steps = [];
  final TextEditingController _controller = TextEditingController();

  void _addStep() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: const Text(
            'Add Step',
            style: TextStyle(color: Colors.white),
          ),
          content: TextFormFieldWidget(
            controller: _controller,
            labelText: 'Step Name',
            hintText: 'Ex: Go to the park',
            icon: Icons.edit,
            keyboardType: TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            WhiteFilledButtonWidget(
              buttonText: 'Add step',
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    steps.add(_controller.text); // Insert at the start to display at the top
                    widget.onStepsChanged(steps); // Notify the parent widget of the change
                  });
                  Navigator.of(context).pop();
                  _controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter a valid name')),
                  );
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < steps.length; i++)
          ListTile(
            leading: Column(
              children: [
                if (i != steps.length && i > 0) const Expanded(child: DottedLineConnector()),
                if (i == 0)
                  const Expanded(
                    child: DottedLineConnector(
                      color: Colors.transparent,
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      steps.removeAt(i);
                    });
                  },
                  child: const Icon(Icons.circle, color: Colors.white),
                ),
                if (i != steps.length - 1) const Expanded(child: DottedLineConnector()),

                if (i == steps.length - 1)
                  Expanded(
                    child: Container(
                      child: const DottedLineConnector(
                        color: Colors.transparent,
                      ),
                    ),
                  ), // Custom widget for dotted line
              ],
            ),
            title: Text(
              steps[i],
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ListTile(
          leading: const Icon(Icons.circle, color: Colors.grey),
          title: const Text(
            'Add a step',
            style: TextStyle(fontSize: 18.0),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addStep,
          ),
        ),
      ],
    );
  }
}

class DottedLineConnector extends StatelessWidget {
  final Color? color;
  const DottedLineConnector({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 2, color: color ?? Colors.white, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
