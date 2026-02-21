const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/assets/stylesheets/**/*.scss',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      aspectRatio: {
        'square': '1/1',
      },
      fontFamily: {
        serif: ["'Libre Caslon Text'", ...defaultTheme.fontFamily.serif],
        sans: ['Montserrat', ...defaultTheme.fontFamily.sans],
      },
      maxWidth: {
        '7xl': '81rem',
      },
      colors: {
        background: {
          DEFAULT: '#fbf7f4',
          highlighted: '#f7f4ed',
          'highlighted-2': '#ede6d3',
          'highlighted-3': '#edeae1',
          inverted: '#3a3631'
        },
        foreground: {
          DEFAULT: '#4a4a47',
          'inverted': '#fbf7f4'
        },
        accent: {
          DEFAULT: '#c5ae8f'
        },
        primary: {
          50:  '#e6f0fb',
          100: '#cce0f7',
          200: '#99c2ef',
          300: '#66a3e7',
          400: '#3385df',
          500: '#0b6fd3', // base brand blue
          600: '#095fb4',
          700: '#074f95',
          800: '#053f76',
          900: '#032f57',
        },
        secondary: {
          50:  '#e9f9ef',
          100: '#d3f3df',
          200: '#a7e7bf',
          300: '#6fd89a',
          400: '#39c878',
          500: '#16b364', // base brand green
          600: '#129a56',
          700: '#0e7f47',
          800: '#0b6a3b',
          900: '#08522e',
        }
      },
      typography: (theme) => ({
        DEFAULT: {
          css: {
            '--tw-prose-headings': theme('colors.foreground.DEFAULT'),
            color: theme('colors.foreground.DEFAULT'),
          },
        },
        lg: {
          css: {
            color: theme('colors.foreground.DEFAULT'),
            'line-height': '1.3',
          },
        }
      }),
    },
    aspectRatio: {
      'video': '16/9',
      'big-image': '316/277'
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
