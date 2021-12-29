import React from "react";
import { Helmet } from "react-helmet";
import _ from "lodash";

import { withPrefix, attribute } from "../utils";
import "../sass/main.scss";
import Header from "./Header";
import Footer from "./Footer";

export default class Body extends React.Component {
  render() {
    return (
      <React.Fragment>
        <Helmet>
          <title>
            {_.get(this.props, "pageContext.frontmatter.seo.title", null)
              ? _.get(this.props, "pageContext.frontmatter.seo.title", null)
              : _.get(this.props, "pageContext.frontmatter.title", null) +
                " | " +
                _.get(this.props, "pageContext.site.siteMetadata.title", null)}
          </title>
          <meta charSet="utf-8" />
          <meta
            name="viewport"
            content="width=device-width, initialScale=1.0"
          />
          <meta name="google" content="notranslate" />
          <meta
            name="description"
            content={
              _.get(
                this.props,
                "pageContext.frontmatter.seo.description",
                null
              ) || ""
            }
          />
          {_.get(this.props, "pageContext.frontmatter.seo.robots", null) && (
            <meta
              name="robots"
              content={_.join(
                _.get(this.props, "pageContext.frontmatter.seo.robots", null),
                ","
              )}
            />
          )}
          {_.map(
            _.get(this.props, "pageContext.frontmatter.seo.extra", null),
            (meta, meta_idx) => {
              let key_name = _.get(meta, "keyName", null) || "name";
              return _.get(meta, "relativeUrl", null) ? (
                _.get(
                  this.props,
                  "pageContext.site.siteMetadata.domain",
                  null
                ) &&
                  (() => {
                    let domain = _.trim(
                      _.get(
                        this.props,
                        "pageContext.site.siteMetadata.domain",
                        null
                      ),
                      "/"
                    );
                    let rel_url = withPrefix(_.get(meta, "value", null));
                    let full_url = domain + rel_url;
                    return (
                      <meta
                        key={meta_idx}
                        {...attribute(key_name, _.get(meta, "name", null))}
                        content={full_url}
                      />
                    );
                  })()
              ) : (
                <meta
                  key={meta_idx + ".1"}
                  {...attribute(key_name, _.get(meta, "name", null))}
                  content={_.get(meta, "value", null)}
                />
              );
            }
          )}
          <link
            href="https://fonts.googleapis.com/css?family=Roboto:400,400i,700,700i&display=swap"
            rel="stylesheet"
          />
          {_.get(this.props, "pageContext.site.siteMetadata.favicon", null) && (
            <link
              rel="icon"
              href={withPrefix(
                _.get(this.props, "pageContext.site.siteMetadata.favicon", null)
              )}
            />
          )}
        </Helmet>
        <div
          id="page"
          className={
            "site style-" +
            _.get(
              this.props,
              "pageContext.site.siteMetadata.layout_style",
              null
            ) +
            " palette-" +
            _.get(this.props, "pageContext.site.siteMetadata.palette", null)
          }
        >
          <Header {...this.props} />
             <a className="github-corner" href="https://github.com/bgoonz/" aria-label="View source on Github">
        <svg aria-hidden="true" width={40} height={40} viewBox="0 0 250 250" style={{zIndex: 100000, fill: '#000000af', color: '#fff', position: 'fixed', top: '0px', border: 0, left: '0px', transform: 'scale(-1.5, 1.5)'}}>
          <path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z" />
          <path className="octo-arm" d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style={{transformOrigin: '130px 106px'}} />
          <path className="octo-body" d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" />
        </svg>
      </a>
          <div id="content" className="site-content">
            <div className="inner">
              <main id="main" className="site-main">
                {this.props.children}
              </main>
              <Footer {...this.props} />
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}
