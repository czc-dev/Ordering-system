/* eslint no-undef: 0 */
const { environment } = require('@rails/webpacker');

const resolve = require('./partial/resolve');
const babelLoader = require('./partial/babel-loader');

environment.config.merge(resolve);
environment.config.merge(babelLoader);

module.exports = environment;
