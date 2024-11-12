# hugo-petermac.com
The petermac.com website as supported by the Hugo static site generator

## How it works
I've got a content folder with a combination of stand alone pages (about, services, contact etc), then a 'posts' folder under which I have year/month folders where post material goes.

Through lessons learned, I'd removed any UI based operations into a self-named themes folder. This contains the code I used from the original theme with modifications to suit my specific needs. 

It is possible to use a theme and keep it intact while replicating files in your own layouts folder but I found myself continually editing the wrong version of the file and wondering why things weren't working. In the end I decided to keep the themes/peter-mac-theme folder and focus on getting that part working to process outputs according to my needs.

For search, I've opted for [Pagefind](https://pagefind.app) which acts as a lightweight indexer of your content and the implementation is relatively straightforward.

To build the Pagefind index locally, I use the python option (as opposed to npm)

```
python3 -m venv hugoenv
source hugoenv/bin/activate
```

```bash
python3 -m pip install 'pagefind[extended]'
```

and then...

```bash
python3 -m pagefind --site public --serve
```


For deployment, I'm pushing the content to cloudflare pages. Initially I used the CF web portal to create the pages site and set up a project, but then when I saw the ability to use a CLI tool which fits nicely into my workflow, I was all set. 

## Publish Process
1. Create a new folder under the Content/Year/Month structure.  I will usually name the folder with the name of the post I'm about to create. 

2. Create an index.md file within the folder.

3. Add any images to the folder and refer to them in the content with the necessary markdown.

4. When happy with the article wording run the build script (build.sh).

5. To view in local preview (before committing anything) run the serve.sh script. This executes a local tcp service on whatever port you need (I go with default 3000)

6. Once happy with the content, commit everything to git with a simple git commit and git push.

7. Finally run the cloudflare_deploy script (which uses the wrangler command) to push the latest updates to the live site.

