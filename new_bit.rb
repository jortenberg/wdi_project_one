	<div>
		<a href="/categories/subscribe">subscribe to this category.</a><br>
	  <h4>Vote On This Category!</h4>

	  <form action="/categories/thumbsup/<%= category.id %>" method="POST">
	    <input type="hidden" name="_method" value="PUT">
	    <button>Thumbsup</button>
	  </form>

	  <p>Thumbsup total: <%= category.upvotes %><br>
	    -------------------</p>

	 	<form action="/categories/thumbsdown/<%= category.id %>" method="POST">
	    <input type="hidden" name="_method" value="PUT">
	    <button>Thumbsdown</button>
		</form>

	  <p>Thumbsdown total: <%= category.downvotes %></p>
	</div>

	get("/categories/:id/posts") do #shows all posts chron backwards in 1 category
  empty_cat = params["category.id"]
  posts = Post.where(:category_id => params["category.id"])
  category = Category.find_by({id: params["category.id"]})