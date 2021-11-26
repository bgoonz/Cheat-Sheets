import React from 'react';
import _ from 'lodash';

import {withPrefix, markdownify} from '../utils';
import CtaButtons from './CtaButtons';

export default class SectionContent extends React.Component {
    render() {
        let section = _.get(this.props, 'section', null);
        return (
            <section id={_.get(section, 'section_id', null)} className="block block-text">
              {_.get(section, 'title', null) && (
              <h2 className="block-title underline inner-sm">{_.get(section, 'title', null)}</h2>
              )}
              {_.get(section, 'image', null) && (
              <div className="block-image">
                <img src={withPrefix(_.get(section, 'image', null))} alt={_.get(section, 'image_alt', null)} />
              </div>
              )}
              {_.get(section, 'content', null) && (
              <div className="block-content inner-sm">
                {markdownify(_.get(section, 'content', null))}
              </div>
              )}
              {_.get(section, 'actions', null) && (
              <div className="block-buttons inner-sm">
                <CtaButtons {...this.props} actions={_.get(section, 'actions', null)} />
              </div>
              )}
            </section>
        );
    }
}
