// ------------------------------------------------------------------------//
// Description: Demo application source code
// Repository: https://github.com/erickangMSFT
// Author: Eric Kang
// License: MIT
// ------------------------------------------------------------------------//

(() => {

    module.exports = {
        formatSpecList: formatSpecList,
        getFormatArgument: getFormatArgument
    };

    function formatSpecList(specList) {
        var index = specList.indexOf('\n');
        var last = 0;
        var specId = 1;
        var result = '[';
        while (index > -1) {
            var spec = specList.substring(last, index);
            last = index + 1;
            index = specList.indexOf('\n', last);
            result += '{ "id": ' + specId + ', "specFile": "' + spec;
            if (index < 1) // detects the last json object.
                result += '" }';
            else
                result += '" },';
            specId += 1;
        }
        result += ']';
        return result;
    }

    function getFormatArgument(format) {
        var formatArg = {};
        switch (format) {
            case 'json':
                formatArg = { "arg": "-fj", "type": "json" };
                break;
            case 'html':
                formatArg = { "arg": "-fh", "type": "html" };
                break;
            case 'document':
            default:
                formatArg = { "arg": "-fd", "type": "json" };
        }
        return formatArg;
    }

})();