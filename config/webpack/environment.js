/* eslint no-undef: 0 */
const { environment } = require('@rails/webpacker');

const resolve = require('./partial/resolve');

environment.config.merge(resolve);

module.exports = environment;
