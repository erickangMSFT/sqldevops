const yaml = require('js-yaml');
const fs = require('fs');

(() => {
    module.exports = {
        getConfig: getConfig
    };

    function getConfig(yamlFile) {
        // Get document, or throw exception on error
        try {
            var config = yaml.safeLoad(fs.readFileSync(yamlFile, 'utf8'));
        } catch (e) {
            console.log(e);
        }
        return config;
    }
})();