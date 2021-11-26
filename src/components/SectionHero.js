import React from 'react';
import _ from 'lodash';

import {markdownify} from '../utils';
import CtaButtons from './CtaButtons';

export default class SectionHero extends React.Component {
    render() {
        let section = _.get(this.props, 'section', null);
        return (
            <section id={_.get(section, 'section_id', null)} className="block block-hero">
              {_.get(section, 'title', null) && (
              <h1 className="block-title inner-sm">{_.get(section, 'title', null)}</h1>
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
