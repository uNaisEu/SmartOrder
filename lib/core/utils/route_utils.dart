enum Pages {
  unknown,
  menu,
  basket,
}

Pages getPageByPath(String pagePath) {
  switch (pagePath) {
    case '/menu':
      return Pages.menu;
    case '/basket':
      return Pages.basket;
    default:
      return Pages.unknown;
  }
}

Pages getPageByName(String pageName) {
  switch (pageName) {
    case 'menu':
      return Pages.menu;
    case 'basket':
      return Pages.basket;
    default:
      return Pages.unknown;
  }
}

extension AppPageExtension on Pages {
  String get pagePath {
    switch (this) {
      case Pages.menu:
        return "/menu";
      case Pages.basket:
        return "/basket";
      default:
        return "/unknown";
    }
  }

  String get pageName {
    switch (this) {
      case Pages.menu:
        return "menu";
      case Pages.basket:
        return "basket";
      default:
        return "/unknown";
    }
  }
}