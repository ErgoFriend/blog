<template>
  <div class="blogs">
    <v-layout class="tags" justify-center wrap>
      <!-- <a href="/posts/"><v-chip label outline color="blue">All</v-chip></a> -->
      <v-chip small label flat outline color="blue" @click="findArticles()">All</v-chip>
      <div v-for="tag in tagsSorted" :key="tag">
        <!-- <a :href="'/blog/?tag=' + tag.name"><v-chip label outline color="blue">#{{ tag.name }} {{ tag.value }}</v-chip></a> -->
        <v-chip small label flat outline color="blue" @click="findArticles(tag.name)">#{{ tag.name }} {{ tag.value }}</v-chip>
      </div>
    </v-layout>
    <div v-if="!posts == {}">
      <div v-for="post in posts" :key="post.title" class="post">
        <v-card v-if="post.title">
          <v-card-title>
            <div>
              <span class="headline"><a v-bind:href="post.path">{{post.title}}</a></span><br><br>
              <span>{{post.frontmatter.description}}</span>
            </div>
          </v-card-title>
          <v-card-actions>
            <v-layout wrap>
            <v-chip :key="tag" v-for="tag in post.frontmatter.tag" label small outline color="blue" @click="findArticles(tag)">{{tag}}</v-chip>
            </v-layout>
              <v-layout justify-end>
              <v-btn small flat color="blue"><a v-bind:href="post.path">続きを読む</a></v-btn>
              </v-layout>
          </v-card-actions>
        </v-card>
      </div>
    </div>
    <div v-else>
      <div v-for="post in preposts" :key="post.title" class="post">
        <v-card v-if="post.title">
          <v-card-title>
            <div>
              <span class="headline"><a v-bind:href="post.path">{{post.title}}</a></span><br><br>
              <span>{{post.frontmatter.description}}</span>
            </div>
          </v-card-title>
          <v-card-actions>
            <v-layout wrap>
            <v-chip :key="tag" v-for="tag in post.frontmatter.tag" label small outline color="blue" @click="findArticles(tag)">{{tag}}</v-chip>
            </v-layout>
              <v-layout justify-end>
              <v-btn flat color="blue"><a v-bind:href="post.path">続きを読む</a></v-btn>
              </v-layout>
          </v-card-actions>
        </v-card>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data: function() {
    return {
      posts: {}
    };
  },
  methods: {
    findArticles(tagname) {
      const temp = this.$site.pages
        // blogディレクトリ以下を投稿記事一覧表示の対象とする
        .filter(post => post.path.startsWith('/blog/'))
        // dateに設定した日付の降順にソートする
        .sort(
          (a, b) => new Date(b.frontmatter.date) - new Date(a.frontmatter.date)
        );
      if (!tagname) {
        this.posts = temp;
      } else {
        this.posts = temp.filter(post =>
          post.frontmatter.tag.some(tag => tag === tagname)
        );
      }
      // 動く
      // const temp = [
      // { tag: ['a','b'] ,title:'ab'},
      //   { tag: ['c','b'] ,title:'cb'},
      //   { tag: ['a','c'] ,title:'ac'}
      // ];
      // const result = temp.filter(post => post.tag.some(tag => tag === 'a'));
      // console.log(result);
      // for(var i=0,l=result.length;i<l;i++){
      //    console.log(result[i].title)
      // }
    }
  },
  computed: {
    tags() {
      const tagsAll = this.$site.pages
        .filter(page => page.path.startsWith('/blog/'))
        .map(page => page.frontmatter.tag)
        .reduce((acc, tags) => {
          if (!acc) {
            return tags;
          } else {
            return acc.concat(tags);
          }
        }, []);

      const tagsSummary = {};
      for (let i = 0; i < tagsAll.length; i++) {
        const t = tagsAll[i];
        if (!tagsSummary[t]) tagsSummary[t] = 0;
        tagsSummary[t]++;
      }
      const tags = [];
      for (let key in tagsSummary) {
        if (key == 'null') continue;
        tags.push({
          name: key,
          value: tagsSummary[key]
        });
      }
      return tags;
    },
    tagsSorted() {
      return this.tags.sort((a, b) => {
        if (a.value < b.value) return 1;
        if (a.value > b.value) return -1;
        if (a.name < b.name) return -1;
        if (a.name > b.name) return 1;
        return 0;
      });
    },
    preposts() {
      return (
        this.$site.pages
          // blogディレクトリ以下を投稿記事一覧表示の対象とする
          .filter(post => post.path.startsWith('/blog/'))
          // dateに設定した日付の降順にソートする
          .sort(
            (a, b) =>
              new Date(b.frontmatter.date) - new Date(a.frontmatter.date)
          )
      );
    }
  }
};
</script>
<style scoped>
.blogs {
  padding: 0% 10%;
}
.post {
  margin: 2rem;
}
.tags {
  margin: 2rem;
}
</style>
