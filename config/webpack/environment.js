const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        Popper: ['popper.js', 'default'],
        Rails: '@rails/ujs'
    })
)

const config = environment.toWebpackConfig();
config.resolve.alias = {
    jquery: 'jquery/src/jquery'
};

module.exports = environment
