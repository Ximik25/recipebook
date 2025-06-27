import 'package:flutter/material.dart';

void main() => runApp(RecipeBookApp());

class RecipeBookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Книга Рецептов', home: RecipeListScreen());
  }
}

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<String> recipes = [];

  void _addRecipe(String recipe) {
    setState(() {
      recipes.add(recipe);
    });
  }

  void _removeRecipe(int index) {
    setState(() {
      recipes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Список Рецептов')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeRecipe(index),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(recipes[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipeScreen(onAdd: _addRecipe),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddRecipeScreen extends StatelessWidget {
  final Function(String) onAdd;
  final TextEditingController controller = TextEditingController();

  AddRecipeScreen({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить Рецепт')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Название рецепта'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onAdd(controller.text);
                Navigator.pop(context);
              },
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final String recipe;

  RecipeDetailScreen(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe)),
      body: Center(child: Text('Детали рецепта: $recipe')),
    );
  }
}

// Дополнительный экран – например, настройки
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: Center(child: Text('Настройки приложения')),
    );
  }
}
