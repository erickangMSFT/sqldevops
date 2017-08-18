// ------------------------------------------------------------------------//
// Description: Demo application source code
// Repository: https://github.com/erickangMSFT
// Author: Eric Kang
// License: MIT
// ------------------------------------------------------------------------//

(() => {

    module.exports = {
        formatSpecList: formatSpecList
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
            if (index < 1)
                result += '" }';
            else
                result += '" },';
            specId += 1;
        }
        result += ']';
        return result;
    }

    function formatAllResults(res) { }

    function formatSpecResult(res) { }

})();