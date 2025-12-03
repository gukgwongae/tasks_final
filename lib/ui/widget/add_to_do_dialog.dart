import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasks/core/app_theme.dart';
import 'package:tasks/domain/view_model/home_page_view_model.dart';
import 'package:tasks/data/model/to_do_model.dart';
import 'package:uuid/uuid.dart';

class AddToDoDialog extends HookConsumerWidget {
  const AddToDoDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = useState(false);
    final isDescriptionActivated = useState(false);
    final focusNode = useFocusNode();
    final controller1 = useTextEditingController();
    final controller2 = useTextEditingController();
    final textValue = useValueListenable(controller1);

    void saveTodo() {
      if (textValue.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '할 일을 입력해주세요.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red.withValues(alpha: 0.8),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        final toDo = ToDoModel(
          id: const Uuid().v4(),
          title: controller1.text.trim(),
          description: isDescriptionActivated.value
              ? controller2.text.trim()
              : null,
          isFavorite: isFavorite.value,
          isDone: false,
          createdAt: DateTime.now(),
        );

        ref.read(homePageViewModelProvider.notifier).addTodo(toDo: toDo);
      }
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: vrc(context).background100,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '새 할 일',
                hintStyle: TextStyle(
                  color: vrc(context).textColor100,
                  fontSize: 16,
                ),
              ),
              style: TextStyle(color: vrc(context).textColor200, fontSize: 16),
              maxLines: 1,
              autofocus: true,
              focusNode: focusNode,
              keyboardType: TextInputType.text,
              onSubmitted: (value) => saveTodo(),
            ),
            if (isDescriptionActivated.value)
              Flexible(
                child: TextField(
                  controller: controller2,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '세부정보 추가',
                  ),
                  maxLines: null, // 엔터로 줄바꿈 허용
                  keyboardType: TextInputType.multiline,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 12,
                    children: [
                      if (!isDescriptionActivated.value)
                        InkWell(
                          onTap: () => isDescriptionActivated.value =
                              !isDescriptionActivated.value,
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Icon(Icons.short_text_rounded, size: 24),
                            ),
                          ),
                        ),
                      InkWell(
                        onTap: () => isFavorite.value = !isFavorite.value,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Icon(
                              isFavorite.value
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => saveTodo(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Text(
                        '저장',
                        style: TextStyle(
                          color: textValue.text.trim().isNotEmpty
                              ? fxc(context).activeColor
                              : vrc(context).textColor100,
                          fontSize: 16,
                          fontWeight: textValue.text.trim().isNotEmpty
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
