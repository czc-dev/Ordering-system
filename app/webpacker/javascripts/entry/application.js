/* eslint no-undef:0 */
import '@style/entry/application.scss';

require('turbolinks').start();

import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';

const application = Application.start();
const context = require.context('@js/controllers', true, /\.js$/);
application.load(definitionsFromContext(context));
