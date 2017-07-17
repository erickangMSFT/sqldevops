// ------------------------------------------------------------------------//
// Description: Demo application source code
// Repository: https://github.com/erickangMSFT
// Author: Eric Kang
// License: MIT
// ------------------------------------------------------------------------//

(()=> {

    module.exports ={
        getSqlError: getSqlError
    };

    function getSqlError(err) {
        const sqlError = {};
        sqlError.message = err.message;
        sqlError.status = 'mssql query execution error';
        sqlError.stack = err.stack;
        return sqlError;
    }
    
})();