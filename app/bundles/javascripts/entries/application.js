import '@style/entries/application.scss';
// remote: true使う場合コメント外してください。
// import "rails-ujs";

require('turbolinks').start();

import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';

const application = Application.start();
const context = require.context('@js/controllers', true, /\.js$/);
application.load(definitionsFromContext(context));
