Seddit.Views.CommentView = Backbone.View.extend({
  template: JST["comment"],

  tagName: "ul",

  className: "comment",

  attributes: function() {
    return {
      "data-id": this.model.get("id")
    }
  },

  events: {

  },

  initialize: function(options) {
    this.listenTo(this.model, "sync change update", this.render);
    this.listenTo(this.model, "remove", this.destroy);
    this.listenTo(this.model.vote, "sync", this.updateVoteStatus);
    this.listenTo(this.model.vote, "destroy", this.removeVote);
    //pseudo-render to get elements in place for full render
    this.$el.html(this.template({ comment: this.model }));
  },

  render: function() {
    //re-render only own info, without clearing child comments from subShowView
    this.$el.children().first().remove();
    this.$el.prepend(this.template({
      comment: this.model
    }));
    return this;
  },

  updateVoteStatus: function(vote) {
    this.model.set({
      "upvoted": vote.get("up")
    });
    this.render();
  },

  removeVote: function() {
    this.model.vote.unset("id");
    this.model.vote.unset("up");
    this.render();
  }
})