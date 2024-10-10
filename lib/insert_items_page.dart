import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsertItemsPage extends StatefulWidget {
  const InsertItemsPage({super.key});

  @override
  State<InsertItemsPage> createState() => _InsertItemsPageState();
}

class _InsertItemsPageState extends State<InsertItemsPage> {
  @override
  void initState() {
    super.initState();
    insertRestaurantItems(); // Call the function here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Restaurant Items'),
      ),
      body: const Center(
        child: Text('Inserting data...'),
      ),
    );
  }
}

void insertRestaurantItems() async {
  // Reference to the Firestore collection
  CollectionReference restaurantItems =
      FirebaseFirestore.instance.collection('restaurant_items');

  // List of items to insert
  List<Map<String, dynamic>> items = [
    {
      "name": "Paneer Tikka",
      "description": "Grilled marinated paneer served with mint chutney.",
      "type": true,
      "category": "Snacks",
      "cost": 180,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Chicken Biryani",
      "description": "Aromatic rice cooked with tender chicken and spices.",
      "type": false,
      "category": "Biryani",
      "cost": 350,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Masala Chai",
      "description": "Traditional Indian spiced tea served hot.",
      "type": true,
      "category": "Drinks",
      "cost": 50,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Prawn Curry",
      "description": "Fresh prawns cooked in a rich coconut curry sauce.",
      "type": false,
      "category": "Seafood",
      "cost": 420,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Tomato Soup",
      "description": "Creamy tomato soup garnished with fresh herbs.",
      "type": true,
      "category": "Soups",
      "cost": 120,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Veg Dim Sum",
      "description": "Steamed dumplings filled with vegetables.",
      "type": true,
      "category": "Dim Sum",
      "cost": 200,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Grilled Chicken",
      "description": "Juicy grilled chicken served with a side of vegetables.",
      "type": false,
      "category": "Continental",
      "cost": 320,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Cheeseburger",
      "description": "Classic cheeseburger with lettuce, tomato, and cheese.",
      "type": false,
      "category": "Fast Food",
      "cost": 150,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Gluten-Free Pizza",
      "description":
          "Delicious pizza with a gluten-free crust and veggie toppings.",
      "type": true,
      "category": "Gluten-Free",
      "cost": 280,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Fish Tacos",
      "description":
          "Grilled fish served in soft tortillas with a tangy salsa.",
      "type": false,
      "category": "Seafood",
      "cost": 250,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Ffish_tacos.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Vegetable Spring Rolls",
      "description":
          "Crispy rolls stuffed with mixed vegetables and served with a sweet chili sauce.",
      "type": true,
      "category": "Snacks",
      "cost": 120,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_spring_rolls.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Pepperoni Pizza",
      "description": "Classic pizza topped with pepperoni slices and cheese.",
      "type": false,
      "category": "Fast Food",
      "cost": 300,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fpepperoni_pizza.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Chocolate Milkshake",
      "description": "Rich and creamy milkshake made with chocolate ice cream.",
      "type": true,
      "category": "Drinks",
      "cost": 120,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fchocolate_milkshake.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Caesar Salad",
      "description":
          "Crisp romaine lettuce tossed in Caesar dressing, topped with croutons and Parmesan.",
      "type": true,
      "category": "Continental",
      "cost": 200,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fcaesar_salad.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Garlic Bread",
      "description": "Toasted bread topped with garlic butter and herbs.",
      "type": true,
      "category": "Snacks",
      "cost": 100,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fgarlic_bread.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Sushi Roll",
      "description": "Freshly made sushi roll with salmon, avocado, and rice.",
      "type": false,
      "category": "Seafood",
      "cost": 350,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fsushi_roll.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Gluten-Free Pasta",
      "description":
          "Pasta made with gluten-free ingredients, served with tomato sauce.",
      "type": true,
      "category": "Gluten-Free",
      "cost": 260,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fgluten_free_pasta.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Butter Chicken",
      "description":
          "Tender chicken pieces cooked in a creamy tomato-based gravy.",
      "type": false,
      "category": "Indian",
      "cost": 340,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fbutter_chicken.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Paneer Butter Masala",
      "description": "Cottage cheese cooked in a rich and creamy tomato sauce.",
      "type": true,
      "category": "Indian",
      "cost": 280,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fpaneer_butter_masala.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Chicken Shawarma",
      "description":
          "Marinated chicken grilled and served in pita bread with garlic sauce.",
      "type": false,
      "category": "Fast Food",
      "cost": 180,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fchicken_shawarma.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Mango Smoothie",
      "description": "Refreshing smoothie made with fresh mangoes and yogurt.",
      "type": true,
      "category": "Drinks",
      "cost": 150,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fmango_smoothie.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Lobster Bisque",
      "description":
          "Rich and creamy soup made with lobster and a hint of sherry.",
      "type": false,
      "category": "Seafood",
      "cost": 400,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Flobster_bisque.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Samosa",
      "description": "Crispy pastry filled with spiced potatoes and peas.",
      "type": true,
      "category": "Snacks",
      "cost": 60,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fsamosa.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Crab Rangoon",
      "description":
          "Crispy wontons filled with crab and cream cheese, served with sweet chili sauce.",
      "type": false,
      "category": "Dim Sum",
      "cost": 220,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fcrab_rangoon.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Hot and Sour Soup",
      "description":
          "Spicy and tangy soup with tofu, mushrooms, and bamboo shoots.",
      "type": true,
      "category": "Soups",
      "cost": 180,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fhot_and_sour_soup.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Grilled Cheese Sandwich",
      "description":
          "Classic sandwich with melted cheese grilled to perfection.",
      "type": true,
      "category": "Fast Food",
      "cost": 130,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fgrilled_cheese_sandwich.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Chicken Dumplings",
      "description":
          "Steamed dumplings filled with chicken, served with soy sauce.",
      "type": false,
      "category": "Dim Sum",
      "cost": 210,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fchicken_dumplings.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Avocado Salad",
      "description":
          "Fresh salad with sliced avocado, tomatoes, and cucumbers.",
      "type": true,
      "category": "Continental",
      "cost": 240,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Favocado_salad.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Lamb Biryani",
      "description":
          "Aromatic basmati rice cooked with tender lamb and traditional spices.",
      "type": false,
      "category": "Biryani",
      "cost": 320,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Flamb_biryani.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Vegan Burger",
      "description":
          "Plant-based burger patty served in a bun with lettuce, tomato, and vegan mayo.",
      "type": true,
      "category": "Gluten-Free",
      "cost": 280,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fvegan_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "BBQ Chicken Wings",
      "description": "Juicy chicken wings coated in tangy BBQ sauce.",
      "type": false,
      "category": "Fast Food",
      "cost": 240,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fbbq_chicken_wings.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Paneer Tikka",
      "description":
          "Spiced paneer cubes grilled to perfection, served with mint chutney.",
      "type": true,
      "category": "Snacks",
      "cost": 220,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fpaneer_tikka.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Fish and Chips",
      "description":
          "Crispy fried fish served with French fries and tartar sauce.",
      "type": false,
      "category": "Seafood",
      "cost": 320,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Ffish_and_chips.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Tom Yum Soup",
      "description":
          "Spicy and sour Thai soup with shrimp, lemongrass, and mushrooms.",
      "type": false,
      "category": "Soups",
      "cost": 200,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Ftom_yum_soup.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Tandoori Chicken",
      "description":
          "Chicken marinated in yogurt and spices, roasted in a tandoor oven.",
      "type": false,
      "category": "Snacks",
      "cost": 260,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Ftandoori_chicken.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Beef Burger",
      "description":
          "Juicy beef patty served in a bun with lettuce, cheese, and tomato.",
      "type": false,
      "category": "Fast Food",
      "cost": 300,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fbeef_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Egg Fried Rice",
      "description":
          "Stir-fried rice with eggs, vegetables, and a hint of soy sauce.",
      "type": true,
      "category": "Continental",
      "cost": 180,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fegg_fried_rice.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Butter Chicken",
      "description": "Tender chicken pieces in a rich, creamy tomato sauce.",
      "type": false,
      "category": "Indian",
      "cost": 280,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fbutter_chicken.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Falafel Wrap",
      "description":
          "Crispy falafel wrapped in pita with lettuce, tomato, and tahini sauce.",
      "type": true,
      "category": "Fast Food",
      "cost": 190,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Ffalafel_wrap.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Grilled Salmon",
      "description":
          "Perfectly grilled salmon served with a lemon butter sauce.",
      "type": false,
      "category": "Seafood",
      "cost": 400,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fgrilled_salmon.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Gluten-Free Pasta",
      "description":
          "Pasta made from gluten-free ingredients, served with marinara sauce.",
      "type": true,
      "category": "Gluten-Free",
      "cost": 250,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fgluten_free_pasta.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Prawn Biryani",
      "description":
          "Fluffy rice cooked with spiced prawns, served with raita.",
      "type": false,
      "category": "Biryani",
      "cost": 350,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fprawn_biryani.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Green Smoothie",
      "description":
          "A healthy smoothie made with spinach, kale, apple, and banana.",
      "type": true,
      "category": "Drinks",
      "cost": 160,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fgreen_smoothie.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Chicken Shawarma",
      "description":
          "Middle Eastern-style marinated chicken wrapped in pita with garlic sauce and pickles.",
      "type": false,
      "category": "Fast Food",
      "cost": 180,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fchicken_shawarma.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Margherita Pizza",
      "description":
          "Classic pizza topped with mozzarella, fresh tomatoes, and basil.",
      "type": true,
      "category": "Continental",
      "cost": 250,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fmargherita_pizza.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Sushi Platter",
      "description":
          "An assortment of fresh sushi, including salmon, tuna, and shrimp.",
      "type": false,
      "category": "Seafood",
      "cost": 550,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fsushi_platter.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Veg Spring Rolls",
      "description":
          "Crispy rolls stuffed with a mix of fresh vegetables and served with sweet chili sauce.",
      "type": true,
      "category": "Snacks",
      "cost": 120,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_spring_rolls.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Mango Lassi",
      "description": "Refreshing yogurt-based drink blended with ripe mangoes.",
      "type": true,
      "category": "Drinks",
      "cost": 90,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fmango_lassi.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Pepperoni Pizza",
      "description":
          "Thin crust pizza topped with spicy pepperoni and mozzarella cheese.",
      "type": false,
      "category": "Continental",
      "cost": 280,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fpepperoni_pizza.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "BBQ Pork Ribs",
      "description":
          "Tender pork ribs glazed with a tangy BBQ sauce, served with coleslaw.",
      "type": false,
      "category": "Fast Food",
      "cost": 400,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fbbq_pork_ribs.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Vegetable Dim Sum",
      "description":
          "Steamed dumplings filled with fresh vegetables, served with soy sauce.",
      "type": true,
      "category": "Dim Sum",
      "cost": 150,
      "restaurantId": "ANxmBJKocqIHiNCcSV4h",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fvegetable_dim_sum.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Chicken Caesar Salad",
      "description":
          "Crisp romaine lettuce with grilled chicken, parmesan cheese, and croutons tossed in Caesar dressing.",
      "type": false,
      "category": "Snacks",
      "cost": 220,
      "restaurantId": "9SnF5N6mfi7NvkxlgCel",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fchicken_caesar_salad.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Ramen Noodles",
      "description":
          "Japanese-style noodles in a savory broth, topped with pork, boiled eggs, and green onions.",
      "type": false,
      "category": "Soups",
      "cost": 320,
      "restaurantId": "14fWFxpEQb9XCEhGd4pg",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Framen_noodles.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Lamb Kebab",
      "description":
          "Succulent grilled lamb skewers marinated in aromatic spices, served with yogurt dip.",
      "type": false,
      "category": "Snacks",
      "cost": 280,
      "restaurantId": "UYflboBSLuLdI5cm7shQ",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Flamb_kebab.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    },
    {
      "name": "Gluten-Free Brownie",
      "description":
          "Rich chocolate brownie made with gluten-free flour, perfect for dessert.",
      "type": true,
      "category": "Gluten-Free",
      "cost": 100,
      "restaurantId": "zzJYW2qyjRs5J3cCquIb",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fgluten_free_brownie.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a"
    }

    // Add more items in this format
  ];

  for (var item in items) {
    item['imageUrl'] =
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-app-47459.appspot.com/o/images%2Fnew_restaurant_items%2Fveg_burger.jpeg?alt=media&token=c61ea4b5-5122-4a8a-b3c8-1bd97a99a98a';
  }

  // Insert each item into the 'restaurant_items' collection
  for (var item in items) {
    await restaurantItems.add(item).then((value) {
      debugPrint("Item Added: ${item['name']}");
    }).catchError((error) {
      debugPrint("Failed to add item: ${item['name']}, Error: $error");
    });
  }
}
