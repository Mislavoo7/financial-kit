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
        'primary': {
          50:  '#fff5f6',
          100: '#ffe5e8',
          200: '#ffccd2',
          300: '#ff99a6',
          400: '#ff667c',
          500: '#ff7a8a', // base
          600: '#e75f71',
          700: '#c74a5b',
          800: '#a23b4b',
          900: '#7f2e3c',
        },
        'secondary': {
          50:  '#f3f6f9',
          100: '#e2ebf3',
          200: '#c4d6e6',
          300: '#9bb8d3',
          400: '#7098bb',
          500: '#4b769f', // midpoint between lighter tone and base
          600: '#376083',
          700: '#2a4f6d',
          800: '#24496a', // base
          900: '#1a3650',
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
