'use strict';

const gulp = require('gulp');
const nodemon = require('gulp-nodemon');
// const eslint = require('gulp-eslint');

const jsFiles = ['*.js', './src/**/*.js'];

gulp.task('default', ()=> {
    nodemon({
        script: './bin/www',
        ext: 'js',
        env: {
            PORT: 8000,
        },
        ignore: ['./node_modules/**'],
    })
    .on('restart', function() {
        console.log('Restarting...');
    });
});