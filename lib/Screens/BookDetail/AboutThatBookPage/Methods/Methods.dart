import 'package:flutter/material.dart';

import '../AboutThatBookPage.dart';

checkItemType(item) {
  if (item.runtimeType == String) {
    return Text(item);
  } else {
    return Text((item).toString());
  }
}

checkBookCategories(context, categories) {
  if (categories == null) {
    Row(
      children: [
        FilterChip(
            label: Text("none 😢"),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
                side: BorderSide(color: Theme.of(context).primaryColor)),
            onSelected: (bool value) {
              print("selected");
            }),
      ],
    );
  } else if (categories.length == 0) {
    Row(
      children: [
        FilterChip(
            label: Text("none 😢"),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
                side: BorderSide(color: Theme.of(context).primaryColor)),
            onSelected: (bool value) {
              print("selected");
            }),
      ],
    );
  } else if (categories.length != null) {
    if (categories.length == 1) {
      return Row(
        children: [
          FilterChip(
              label: Text(categories[0]),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              }),
        ],
      );
    } else if (categories.length == 2) {
      return Row(
        children: [
          FilterChip(
              label: Text(categories[0]),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              }),
          FilterChip(
              label: Text(categories[1]),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              }),
        ],
      );
    }
    // more than 2
    else {
      return Row(
        children: [
          FilterChip(
              label: Text(categories[0]),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              }),
          FilterChip(
              label: Text(categories[1]),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onSelected: (bool value) {
                print("selected");
              }),
        ],
      );
    }
  }
}

checkBookDescription(bookDescription) {
  if (bookDescription == null) {
    return Text("No description for this book. 😢");
  } else if (bookDescription != null) {
    if (bookDescription.length < 180)
      return Text(bookDescription);
    else if (bookDescription.length >= 180) {
      return Text(bookDescription.substring(0, 180) + "..");
    }
  }
}

checkThumbnail(bookThumbnail) {
  if (bookThumbnail == null) {
    return Container(color: Colors.white);
  } else if (bookThumbnail != null) {
    return Image.network(
      bookThumbnail,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}

checkBookTitle(bookTitle) {
  if (bookTitle == null) {
    return Text("No tile for this book");
  } else if (bookTitle != null) {
    if (bookTitle.length >= 30) {
      return Text(
        bookTitle.substring(0, 20) + "..",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
    return Text(
      bookTitle,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

checkBookAuthors(context, bookAuthorsArr) {
  String authors;

  if (bookAuthorsArr == null) {
    authors = "No authors";
  } else if (bookAuthorsArr.length == 0) {
    authors = "No authors";
  } else if (bookAuthorsArr.length == 1) {
    authors = bookAuthorsArr[0];
  } else if (bookAuthorsArr.length >= 1) {
    authors = getAllAuthors(bookAuthorsArr);
  }

  if (authors.length >= 25) {
    return Text(authors.substring(0, 25) + "..",
        style: TextStyle(
            fontSize: 17,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor));
  } else if (authors.length < 25) {
    return Text(authors,
        style: TextStyle(
            fontSize: 17,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor));
  }
}

getAllAuthors(authors) {
  List<String> authorsList = [];

  for (var i = 0; i < authors.length; i++) {
    authorsList.add(authors[i]);
  }

  return authorsList.toString();
}

getBookcategories(context, bookCategoriesArr) {
  String categories;

  if (bookCategoriesArr == null) {
    categories = "No categories";
    return Row(
      children: [
        FilterChip(
          label: Text(
            categories,
          ),
          backgroundColor: Colors.transparent,
          shape: StadiumBorder(
              side: BorderSide(color: Theme.of(context).primaryColor)),
        )
      ],
    );
  } else if (bookCategoriesArr.length == 0) {
    categories = "No categories";
    return Row(
      children: [
        FilterChip(
            label: Text(
              categories,
            ),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
                side: BorderSide(color: Theme.of(context).primaryColor)),
            onSelected: (bool value) {
              print("selected");
            })
      ],
    );
  } else if (bookCategoriesArr.length == 1) {
    categories = bookCategoriesArr[0];
  } else if (bookCategoriesArr.length >= 1) {
    //categories = getAllcategories(book.volumeInfo.categories);
  }

  return Row(
    children: [
      for (int i = 0; i <= categories.length; i++)
        FilterChip(
            label: Text(
              bookCategoriesArr[i],
            ),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
                side: BorderSide(color: Theme.of(context).primaryColor)),
            onSelected: (bool value) {
              print("selected");
            })
    ],
  );
}

getAllcategories(categoriesArr) {
  List<String> categoriesList = [];

  for (var i = 0; i < categoriesArr.length; i++) {
    categoriesList.add(categoriesArr[i]);
  }
  print(categoriesList);
  return categoriesList;
}

aboutThisBook(context, book) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AboutBookIteam(book)));
}
