<template>
    <div class="projects">
    <v-layout class="tags" justify-center wrap>
      <!-- <a href="/posts/"><v-chip label outline color="blue">All</v-chip></a> -->
      <v-chip small label flat outline color="blue">All</v-chip>
      <div v-for="tag in tagsSorted" :key="tag">
        <!-- <a :href="'/blog/?tag=' + tag.name"><v-chip label outline color="blue">#{{ tag.name }} {{ tag.value }}</v-chip></a> -->
        <v-chip small label flat outline color="blue">#{{ tag.name }} {{ tag.value }}</v-chip>
      </div>
    </v-layout>
  <v-layout justify-center wrap>
    <div v-for="post in posts" :key="post">
      <v-card v-if="post.title" class="vcard">
        <v-img
          :src="post.frontmatter.heroImage"
          height="200px" style="background-size: cover;"
        >
        </v-img>
        <v-card-title primary-title>
          <div>
            <span class="headline"><a v-bind:href="$withBase(post.path)">{{post.title}}</a></span><br>
            <span class="grey--text">{{post.frontmatter.description}}</span>
          </div>
        </v-card-title>
        <v-card-actions>
          <v-layout wrap>
          <v-chip :key="tag" v-for="tag in post.frontmatter.tag" small label outline color="blue">{{tag}}</v-chip>
          </v-layout>
            <v-layout justify-end>
            <v-btn small flat color="blue"><a v-bind:href="$withBase(post.path)">続きを読む</a></v-btn>
            </v-layout>
        </v-card-actions>
      </v-card>
    </div>
  </v-layout>
    </div>
</template>
<script src="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.js"></script>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
<script>
// :src="post.frontmatter.heroImage"
// v-bind:href="post.path"
// {{post.title}}
// {{post.frontmatter.description}}
// v-if="post.title"
// v-for="post in posts"

export default {
  computed: {
    tags() {
      const tagsAll = this.$site.pages
        .filter(page => page.path.startsWith('/projects/'))
        .map(page => {
          return page.frontmatter.tag;
        })
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
    posts() {
      return (
        this.$site.pages
          // blogディレクトリ以下を投稿記事一覧表示の対象とする
          .filter(post => post.path.startsWith('/projects/'))
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
.tags {
  margin: 2rem;
}
.vcard {
  margin: 1rem;
  width: 450px;
}
@media screen and (min-width: 480px) and (max-width: 768px) {
  .vcard {
    width: 400px;
  }
}
@media screen and (max-width: 480px) {
  .vcard {
    width: 300px;
  }
}
</style>