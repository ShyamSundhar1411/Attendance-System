// eslint-disable-next-line prettier/prettier
module.exports = function(api) {
  api.cache(true);
  return {
    presets: ["babel-preset-expo"],
  };
};