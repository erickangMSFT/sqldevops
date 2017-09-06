'use strict';

const gulp = require('gulp');
const nodemon = require('gulp-nodemon');
const eslint = require('gulp-eslint');

const watchFiles = ['*.js', './src/**/*.js'];

gulp.task('inject', () => {
    const wiredep = require('wiredep').stream;
    const inject = require('gulp-inject');
    const options = {
        bowerJason: require('./bower.json'),
        directory: './public/lib',
        ignorePath: '../../public'
    };
    const injectSrc = gulp.src(['./public/css/*.css', './public/js/*.js'], { read: false });
    const injectOptions = {
        ignorePath: '/public'
    };
    return gulp.src('./src/views/*.ejs')
        .pipe(wiredep(options))
        .pipe(inject(injectSrc, injectOptions))
        .pipe(gulp.dest('./src/views'));
});

gulp.task('default', ['inject'], () => {
    const options = {
        script: './bin/www',
        delayTime: 1,
        env: {
            PORT: 8000,
        },
        watch: watchFiles,
    };
    return nodemon(options);
});