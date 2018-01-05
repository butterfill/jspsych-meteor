import { Mongo } from 'meteor/mongo';

export const CollectedData = new Mongo.Collection('collected_data');
export const Experiments = new Mongo.Collection('experiments');
