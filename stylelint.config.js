"use strict";

// TODO: Check https://stylelint.io/user-guide/plugins/
// TODO: Check if BEM is enforced

module.exports = {
  extends: [
    "stylelint-config-recommended-scss",
    "stylelint-config-sass-guidelines",
    "stylelint-config-idiomatic-order",
    "stylelint-prettier/recommended"
  ],
  rules: {
    "order/properties-alphabetical-order": null,
    "max-nesting-depth": 3
  }
};

// TODO: New proposed config which adds BEM-pattern
// {
//   "extends": [
//     "stylelint-config-recommended-scss",
//     "stylelint-config-sass-guidelines",
//     "stylelint-config-idiomatic-order",
//     "stylelint-prettier/recommended"
//   ],
//   "plugins": ["stylelint-selector-bem-pattern"],
//   "rules": {
//     "order/properties-alphabetical-order": null,
//     "plugin/selector-bem-pattern": {"preset": "suit"}
//   }
// }
