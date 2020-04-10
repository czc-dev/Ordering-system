// app/webpacker act as root path

module.exports = {
  resolve: {
    alias: {
      '@js': 'javascripts',
      '@style': 'stylesheets',
      '@image': 'images'
    },
    extensions: ['.js']
  },
};
