/* eslint import/no-unresolved: 0 */

import '@style/entry/application.scss';
import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';

require('turbolinks').start();

const application = Application.start();
const context = require.context('@js/controllers', true, /\.js$/);
application.load(definitionsFromContext(context));
