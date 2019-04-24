module.exports = {
  title: 'ErgoFriend',
  description: 'Blog & Showcase',
  head: [
    [
      'link',
      {
        rel: 'icon',
        href: `https://i.gyazo.com/4df386fd64685c61924afbd2a799a51b.png`
      }
    ],
    [
      'link',
      {
        rel: 'stylesheet',
        href: `https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css`
      }
    ],
    [
      'link',
      {
        rel: 'stylesheet',
        href: `https://fonts.googleapis.com/css?family=Noto+Sans+JP`
      }
    ]
  ],
  // Google Analytics ID
  ga: 'UA-126788290-1',
  evergreen: true,
  // customize the links on the navigation bar
  markdown: {
    extendMarkdown: md => {
      md.use(require('markdown-it-task-lists'), { enabled: true });
    }
  },
  themeConfig: {
    // algolia: {
    //   appId: 'APP_ID',
    //   apiKey: 'APP_KEY',
    //   indexName: 'INDEX_NAME'
    // },
    lastUpdated: true, // string | boolean,
    date_format: 'yyyy-MM-dd',
    nav: [
      { text: 'HOME', link: '/', root: true }, // Specify this as the root directory of the blog post
      { text: 'About', link: '/about/' },
      { text: 'Blog', link: '/blog/', tags: true },
      { text: 'Projects', link: '/projects/' }
    ]
  }
};
